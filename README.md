# 🤖 X-UI Smart Query Telegram Bot (MHSanaei Edition)
> **Advanced & Optimized Telegram Bot to monitor X-UI Inbounds with smart session management.**
> **ربات هوشمند و بهینه تلگرام برای استعلام وضعیت کانفیگ‌های پنل X-UI با مدیریت پیشرفته سشن‌ها.**

---

## 🌍 Language / زبان
- [English Description](#english-version)
- [توضیحات فارسی](#persian-version)

---

<a name="english-version"></a>
## 🇬🇧 English Version

### 📝 Description
This bot provides a seamless way for users to check their VPN configuration status (Vless, Vmess, Trojan) directly via Telegram. It is specifically designed for the **MHSanaei** version of X-UI and focuses on performance and ease of use for both admins and clients.

### ✨ Key Features
* **Smart Session Management:** Logins are performed once; cookies are stored and reused to minimize panel overhead.
* **Dynamic Status Calculation:** Automatically detects "Active" or "Disabled" status based on traffic usage and expiration dates.
* **Modern UI/UX:** Utilizes Telegram's latest **Colored Inline Buttons** (Success, Danger, Primary styles).
* **Multi-Panel Support:** Manage multiple servers/panels from a single bot interface.
* **Admin Tools:** Update support ID, edit panel URLs, and monitor all connections via an intuitive admin dashboard.


## Easy Install for vps/server  ( Ubuntu )
Just enter the following command in your server terminal and enter information such as the IP or domain connected to the server, the robot token, and the admin ID.
```
bash <(curl -s https://raw.githubusercontent.com/aminiyt1/X-UI-Telegram-Bot/main/easyinstall.sh)
```



### 🚀 Installation Guide on host
1.  **Database Setup:**
    * Create a MySQL database.
    * Import the `database.sql` file into your database via phpMyAdmin.
2.  **Configuration:**
    * Open `index.php` and fill in the required variables:
        * `$botToken`: Your Telegram Bot Token.
        * `$adminId`: Your numeric Telegram ID.
        * `$dbHost`, `$dbName`, `$dbUser`, `$dbPass`: Database credentials.
3.  **Webhook:**
    * Set your webhook by visiting: 
    * `https://api.telegram.org/bot<YOUR_TOKEN>/setWebhook?url=https://yourdomain.com/index.php`

### 🛠 Adding Panels
When adding a panel, use the following format:
`Name|URL|Username|Password`

> **Note:** The bot supports various URL formats including those with custom paths like:
> `http://Ip:port/custompath`
> `http://Ip:port`
> `https://subDomain:port/custompath`
> `https://subdomain:port`

---

<a name="persian-version"></a>
## 🇮🇷 نسخه فارسی

### 📝 معرفی پروژه
این پروژه یک راهکار قدرتمند برای ادمین‌های پنل X-UI است تا به کاربران خود اجازه دهند بدون نیاز به دسترسی مستقیم به پنل، وضعیت حجم و زمان باقی‌مانده کانفیگ‌های خود را (Vmess, Vless, Trojan) از طریق تلگرام استعلام بگیرند. این ربات با تمرکز بر **سرعت** و **پایداری** طراحی شده است.

### ✨ قابلیت‌های برجسته
* **مدیریت هوشمند سشن:** ربات فقط در صورت نیاز لاگین می‌کند و کوکی‌ها را ذخیره می‌کند تا از بن شدن آی‌پی یا سنگینی پنل جلوگیری شود.
* **محاسبه دقیق وضعیت:** تشخیص خودکار وضعیت "فعال" یا "غیرفعال" حتی در صورت روشن بودن دکمه کلاینت در پنل (بر اساس ترافیک و زمان).
* **رابط کاربری مدرن:** استفاده از دکمه‌های شیشه‌ای رنگی (سبز برای پشتیبانی، قرمز برای حذف و...) مطابق با آخرین آپدیت تلگرام.
* **پشتیبانی از چند پنل:** امکان اتصال همزمان به چندین سرور و مدیریت یکپارچه آن‌ها.
* **سیستم پشتیبانی هوشمند:** امکان تغییر آنی آیدی تلگرام پشتیبانی از داخل منوی مدیریت ربات.

## نصب آسان در سرور مجازی  ( Ubuntu )
کافیست دستور زیر را در ترمینال سرور خود وارد کنید و اطلاعات اولیه مانند ای پی یا دامنه متصل به سرور، توکن ربات و ایدی ادمین را وارد کنید.
```
bash <(curl -s https://raw.githubusercontent.com/aminiyt1/X-UI-Telegram-Bot/main/easyinstall.sh)
```


### 🚀 آموزش راه‌اندازی هاست
1.  **آماده‌سازی دیتابیس:**
    * یک دیتابیس MySQL بسازید.
    * فایل `database.sql` را در آن **Import** کنید.
2.  **تنظیمات کد:**
    * فایل `index.php` را باز کرده و مقادیر زیر را تنظیم کنید:
        * `$botToken`: توکن دریافت شده از BotFather.
        * `$adminId`: آیدی عددی تلگرام شما.
        * مشخصات دیتابیس (Host, Name, User, Pass).
3.  **فعال‌سازی وبهوک:**
    * آدرس فایل خود را در متد `setWebhook` تلگرام ست کنید.

### 🛠 نحوه افزودن پنل
برای افزودن پنل جدید در بخش مدیریت، اطلاعات را به فرمت زیر ارسال کنید:
`نام دلخواه|آدرس پنل|نام کاربری|رمز عبور`

> **💡 نکته مهم:** این ربات به طور کامل از **Web Root Path** پشتیبانی می‌کند. 
> آدرس‌هایی مانند > `http://Ip:port/custompath`
> `http://Ip:port`
> `https://subDomain:port/custompath`
> `https://subdomain:port` به صورت خودکار توسط ربات شناسایی و آنالیز می‌شوند.

---

## ⚖️ License
Distributed under the **MIT License**. See `LICENSE` for more information.

---
**Developed with ❤️ for the X-UI Community.**
**توسعه داده شده با ❤️ برای جامعه کاربران X-UI.**
