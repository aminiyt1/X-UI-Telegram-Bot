<?php
// ==========================================
// تنظیمات ربات و دیتابیس
// ==========================================
$botToken = "TokenBot"; // توکن ربات را اینجا بگذارید
$adminId = 222266666; // عدد عددی چت آیدی ادمین را اینجا بگذارید

$dbHost = "localhost";
$dbName = "name";
$dbUser = "user";
$dbPass = "password";

// اتصال به دیتابیس
try {
    $pdo = new PDO("mysql:host=$dbHost;dbname=$dbName;charset=utf8", $dbUser, $dbPass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) { die("Database Error"); }

// دریافت آپدیت‌ها (شامل پیام و کال‌بک)
$update = json_decode(file_get_contents("php://input"), true);
if (!$update) exit;

if (isset($update['callback_query'])) {
    $chatId = $update['callback_query']['message']['chat']['id'];
    $data = $update['callback_query']['data'];
    $messageId = $update['callback_query']['message']['message_id'];
    $callbackQueryId = $update['callback_query']['id'];
} else {
    $chatId = $update['message']['chat']['id'];
    $text = $update['message']['text'];
    $messageId = $update['message']['message_id'];
}

// دریافت وضعیت کاربر
$stmt = $pdo->prepare("SELECT step, data FROM users WHERE chat_id = ?");
$stmt->execute([$chatId]);
$userData = $stmt->fetch(PDO::FETCH_ASSOC) ?: ['step' => 'none', 'data' => ''];
$userStep = $userData['step'];

$supportQuery = $pdo->query("SELECT value FROM settings WHERE key_name = 'support_id'");
$supportId = $supportQuery->fetchColumn() ?: "Admin";

// کیبوردها
$keyboardUser = json_encode(['keyboard' => [[['text' => '📊 استعلام حجم و زمان']]], 'resize_keyboard' => true]);
$keyboardAdmin = json_encode(['keyboard' => [[['text' => '➕ افزودن پنل'], ['text' => '📋 لیست پنل‌ها']], [['text' => '📊 استعلام حجم و زمان'], ['text' => '⚙️ تنظیم آیدی پشتیبانی']]], 'resize_keyboard' => true]);
$backKey = json_encode(['keyboard' => [[['text' => '🔙 بازگشت']]], 'resize_keyboard' => true]);

// ==========================================
// ۲. پردازش Callback Query (حذف و ویرایش)
// ==========================================
if (isset($update['callback_query'])) {
    if (strpos($data, 'del_') === 0) {
        $id = str_replace('del_', '', $data);
        $pdo->prepare("DELETE FROM panels WHERE id = ?")->execute([$id]);
        answerCallback($callbackQueryId, "✅ پنل با موفقیت حذف شد.");
        // ویرایش پیام قبلی و نمایش لیست جدید
        sendPanelList($chatId, $messageId);
    } 
    elseif (strpos($data, 'edit_') === 0) {
        $id = str_replace('edit_', '', $data);
        updateStep($chatId, 'edit_url', $id);
        sendMessage($chatId, "🔗 لطفا آدرس جدید پنل را ارسال کنید:", $backKey);
        answerCallback($callbackQueryId);
    }
    exit;
}

// ==========================================
// ۳. منطق پیام‌های متنی
// ==========================================

if ($text == '/start' || $text == '🔙 بازگشت') {
    updateStep($chatId, 'none');
    $kb = ($chatId == $adminId) ? $keyboardAdmin : $keyboardUser;
    sendMessage($chatId, "خوش آمدید. یکی از گزینه‌ها را انتخاب کنید:", $kb);
}

// لیست پنل‌ها به صورت شیشه‌ای
elseif ($chatId == $adminId && $text == '📋 لیست پنل‌ها') {
    sendPanelList($chatId);
}

// ویرایش آدرس پنل
elseif ($chatId == $adminId && $userStep == 'edit_url' && $text != '🔙 بازگشت') {
    $panelId = $userData['data'];
    $pdo->prepare("UPDATE panels SET url = ? WHERE id = ?")->execute([trim($text), $panelId]);
    sendMessage($chatId, "✅ آدرس پنل بروزرسانی شد.", $keyboardAdmin);
    updateStep($chatId, 'none');
}

// تنظیم آیدی پشتیبانی
elseif ($chatId == $adminId && $text == '⚙️ تنظیم آیدی پشتیبانی') {
    updateStep($chatId, 'set_support');
    sendMessage($chatId, "آیدی پشتیبانی بدون @:", $backKey);
}
elseif ($chatId == $adminId && $userStep == 'set_support' && $text != '🔙 بازگشت') {
    $newId = str_replace('@', '', $text);
    $pdo->prepare("REPLACE INTO settings (key_name, value) VALUES ('support_id', ?)")->execute([$newId]);
    sendMessage($chatId, "✅ انجام شد.", $keyboardAdmin);
    updateStep($chatId, 'none');
}

// افزودن پنل
elseif ($chatId == $adminId && $text == '➕ افزودن پنل') {
    updateStep($chatId, 'add_panel_data');
    sendMessage($chatId, "فرمت: `Name|Url|User|Pass`", $backKey);
}
elseif ($chatId == $adminId && $userStep == 'add_panel_data' && $text != '🔙 بازگشت') {
    $d = explode("|", $text);
    if (count($d) == 4) {
        $login = loginToXui($d[1], $d[2], $d[3]);
        if ($login['success']) {
            $pdo->prepare("INSERT INTO panels (name, url, username, password, cookie) VALUES (?,?,?,?,?)")->execute([$d[0], $d[1], $d[2], $d[3], $login['cookie']]);
            sendMessage($chatId, "✅ پنل اضافه شد.", $keyboardAdmin);
            updateStep($chatId, 'none');
        } else { sendMessage($chatId, "❌ خطا در لاگین."); }
    }
}

// استعلام حجم و زمان
elseif ($text == '📊 استعلام حجم و زمان') {
    updateStep($chatId, 'wait_config');
    sendMessage($chatId, "لطفاً کانفیگ خود را ارسال کنید:", $backKey);
}
elseif ($userStep == 'wait_config' && $text != '🔙 بازگشت') {
    $uuid = extractUUID($text);
    if (!$uuid) { sendMessage($chatId, "❌ نامعتبر."); } 
    else {
        sendMessage($chatId, "🔍 در حال بررسی...");
        $stmt = $pdo->query("SELECT * FROM panels");
        $found = false;
        while ($panel = $stmt->fetch()) {
            $client = findClient($panel['url'], $panel['cookie'], $uuid);
            if ($client === "LOGIN_REQUIRED") {
                $login = loginToXui($panel['url'], $panel['username'], $panel['password']);
                if ($login['success']) {
                    $pdo->prepare("UPDATE panels SET cookie = ? WHERE id = ?")->execute([$login['cookie'], $panel['id']]);
                    $client = findClient($panel['url'], $login['cookie'], $uuid);
                }
            }
            if (is_array($client)) {
                $found = true;
                $used = $client['up'] + $client['down'];
                $isExp = ($client['total'] > 0 && $used >= $client['total']) || ($client['expiryTime'] > 0 && ($client['expiryTime']/1000) < time());
                $status = ($client['enable'] && !$isExp) ? "✅ فعال" : "❌ غیرفعال";
                $expStr = ($used == 0 && $client['expiryTime'] == 0) ? "شروع از اولین اتصال" : (($client['expiryTime'] > 0) ? date("Y-m-d", $client['expiryTime']/1000) : "نامحدود");

                $msg = "👤 **نام کانفیگ:** {$client['email']}\n📍 **وضعیت:** $status\n📅 **انقضا:** $expStr\n📉 **مصرف:** " . formatBytes($used) . "\n📦 **کل:** " . ($client['total'] > 0 ? formatBytes($client['total']) : "نامحدود") . "\n⬆️ آپلود: " . formatBytes($client['up']) . " | ⬇️ دانلود: " . formatBytes($client['down']);
                
                // دکمه شیشه‌ای سبز (success)
                $inlineKb = json_encode(['inline_keyboard' => [
                    [['text' => '📞 تماس با پشتیبانی', 'url' => "https://t.me/$supportId", 'style' => 'success']]
                ]]);
                
                sendMessage($chatId, $msg, null, $inlineKb);
                updateStep($chatId, 'none');
                break;
            }
        }
        if (!$found) sendMessage($chatId, "❌ یافت نشد.", ($chatId == $adminId ? $keyboardAdmin : $keyboardUser));
    }
}

// ==========================================
// ۴. توابع
// ==========================================

function sendPanelList($chatId, $editMsgId = null) {
    global $pdo, $botToken;
    $stmt = $pdo->query("SELECT * FROM panels");
    $panels = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $keys = [];
    foreach ($panels as $p) {
        $keys[] = [
            ['text' => $p['name'], 'callback_data' => 'none'],
            ['text' => '✏️', 'callback_data' => 'edit_'.$p['id'], 'style' => 'primary'],
            ['text' => '🗑', 'callback_data' => 'del_'.$p['id'], 'style' => 'danger']
        ];
    }
    
    $markup = json_encode(['inline_keyboard' => $keys]);
    $text = "📋 لیست پنل‌ها:\n(برای ویرایش آدرس یا حذف از دکمه‌ها استفاده کنید)";
    
    if ($editMsgId) {
        file_get_contents("https://api.telegram.org/bot$botToken/editMessageText?chat_id=$chatId&message_id=$editMsgId&text=".urlencode($text)."&reply_markup=".urlencode($markup));
    } else {
        sendMessage($chatId, $text, null, $markup);
    }
}

function sendMessage($chatId, $text, $kb = null, $inline = null) {
    global $botToken;
    $data = ['chat_id' => $chatId, 'text' => $text, 'parse_mode' => 'Markdown', 'disable_web_page_preview' => true];
    if ($inline) $data['reply_markup'] = $inline;
    elseif ($kb) $data['reply_markup'] = $kb;
    $ch = curl_init("https://api.telegram.org/bot$botToken/sendMessage");
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data); curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_exec($ch);
}

function answerCallback($id, $text = null) {
    global $botToken;
    file_get_contents("https://api.telegram.org/bot$botToken/answerCallbackQuery?callback_query_id=$id&text=".urlencode($text));
}

function updateStep($chatId, $step, $data = null) {
    global $pdo;
    $pdo->prepare("UPDATE users SET step = ?, data = ? WHERE chat_id = ?")->execute([$step, $data, $chatId]);
}

function formatBytes($b) {
    if ($b <= 0) return "0 B";
    $i = floor(log($b, 1024));
    return round($b / pow(1024, $i), 2) . ' ' . ['B', 'KB', 'MB', 'GB', 'TB'][$i];
}

function extractUUID($c) {
    preg_match('/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i', $c, $m);
    if (!empty($m[0])) return $m[0];
    if (strpos($c, 'vmess://') === 0) {
        $json = json_decode(base64_decode(substr($c, 8)), true);
        return $json['id'] ?? null;
    }
    return null;
}

function loginToXui($url, $u, $p) {
    global $chatId; 
    $base = rtrim($url, '/');
    if (substr($base, -6) === '/login') $base = substr($base, 0, -6);
    $loginUrl = $base . '/login';
    
    $ch = curl_init($loginUrl);
    $postData = ['username' => $u, 'password' => $p];
    
    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postData));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); 
    curl_setopt($ch, CURLOPT_HEADER, true); 
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, 20);
    
    // --- اصلاحات جدید برای رفع خطای 307 ---
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); // دنبال کردن ریدایرکت‌ها
    curl_setopt($ch, CURLOPT_AUTOREFERER, true);
    // ------------------------------------

    curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124 Safari/537.36");
    
    $res = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    $finalUrl = curl_getinfo($ch, CURLINFO_EFFECTIVE_URL); // آدرس نهایی بعد از ریدایرکت
    curl_close($ch);

    if ($curlError) {
        sendMessage($chatId, "❌ خطای شبکه: " . $curlError);
        return ['success' => false];
    }

    if ($httpCode !== 200) {
        sendMessage($chatId, "❌ پنل پاسخ نداد. کد وضعیت: " . $httpCode . "\nآدرس نهایی: " . $finalUrl);
        return ['success' => false];
    }

    // استخراج کوکی از پاسخ نهایی
    preg_match_all('/^Set-Cookie:\s*([^;]*)/mi', $res, $matches);
    $cookie = ""; 
    if (isset($matches[1])) {
        foreach($matches[1] as $item) $cookie .= $item . "; ";
    }
    
    if (empty(trim($cookie))) {
        // برخی پنل‌ها بعد از ریدایرکت کوکی را در بدنه یا هدر نهایی می‌فرستند
        // اگر هنوز خطا داد، احتمالا نام کاربری یا رمز عبور اشتباه است
        return ['success' => false];
    }

    return ['success' => true, 'cookie' => $cookie];
}

function findClient($url, $cookie, $uuid) {
    $base = rtrim($url, '/');
    if (substr($base, -6) === '/login') $base = substr($base, 0, -6);
    
    // آدرس دقیق API برای دریافت لیست اینباندها
    $apiUrl = $base . '/panel/api/inbounds/list';
    
    $ch = curl_init($apiUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_COOKIE, $cookie);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); // اضافه شدن برای هندل کردن مسیرهای دارای Path
    curl_setopt($ch, CURLOPT_TIMEOUT, 15);
    curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/91.0.4472.124 Safari/537.36");
    
    $res = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    // اگر کوکی منقضی شده باشد یا دسترسی رد شود
    if ($httpCode == 302 || $httpCode == 401 || empty($res)) return "LOGIN_REQUIRED";
    
    $json = json_decode($res, true);
    
    // بررسی اینکه آیا پاسخ معتبر است
    if (!isset($json['obj']) || !is_array($json['obj'])) return null;

    foreach ($json['obj'] as $inbound) {
        $settings = json_decode($inbound['settings'], true);
        $clients = $settings['clients'] ?? [];
        
        foreach ($clients as $c) {
            // بررسی تطابق UUID با دقت بالا (پشتیبانی از Vless, Vmess, Trojan)
            $clientId = $c['id'] ?? $c['password'] ?? '';
            
            if (trim($clientId) == trim($uuid)) {
                $up = 0; $down = 0; $email = $c['email'] ?? 'بدون نام';
                
                // استخراج آمار مصرف (در برخی پنل‌ها در clientStats است)
                if (isset($inbound['clientStats']) && is_array($inbound['clientStats'])) {
                    foreach ($inbound['clientStats'] as $stat) {
                        if ($stat['email'] == $email) {
                            $up = $stat['up'] ?? 0;
                            $down = $stat['down'] ?? 0;
                            break;
                        }
                    }
                }
                
                // بازگشت اطلاعات کامل
                return [
                    'email' => $email,
                    'up' => $up,
                    'down' => $down,
                    'total' => $c['totalGB'] ?? 0,
                    'expiryTime' => $c['expiryTime'] ?? 0,
                    'enable' => $c['enable'] ?? true
                ];
            }
        }
    }
    return null; // اگر در این پنل پیدا نشد
}
?>