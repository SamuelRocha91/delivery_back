# <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTchGHKMA3VyA1ySh2ITWb0CIm_cnhF1cGvlQ&s" alt="Full Stack Projects" width="52" height="40" /> تطبيق الت <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTchGHKMA3VyA1ySh2ITWb0CIm_cnhF1cGvlQ&s" alt="Java Projects Logo" width="52" height="40" />  



## 🌐 [![Português](https://img.shields.io/badge/Português-green)](https://github.com/SamuelRocha91/delivery_back/blob/main/README.md) [![Español](https://img.shields.io/badge/Español-yellow)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md) [![English](https://img.shields.io/badge/English-blue)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md) [![Русский](https://img.shields.io/badge/Русский-lightgrey)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md) [![中文](https://img.shields.io/badge/中文-red)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md) [![العربية](https://img.shields.io/badge/العربية-orange)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md)

تمثل هذه المستودع الجزء الخلفي (Back-end) من تطبيق توصيل، بما في ذلك واجهة لإدارة البيانات للمستخدمين ذوي الأدوار (Admin و Developer).

![مثال على استخدام واجهة الإدارة](./assets/admin.gif)

## المستودعات ذات الصلة

-  🛒[تطبيق Consumy](https://github.com/SamuelRocha91/consumy) - تطبيق المستهلك
-  👨‍💼[تطبيق Seller](https://github.com/SamuelRocha91/seller_application) - تطبيق البائع
- 💲 [API Paymenty](https://github.com/SamuelRocha91/paymenty/) - API للدفع

### المفاهيم و Gems المستخدمة

يتناول هذا المشروع ويستخدم المفاهيم و Gems التالية:

- **عمليات خلفية:** استخدام Sidekiq لمعالجة المهام بشكل غير متزامن (مع Redis).
- **التصفح:** تنفيذ التصفح لقوائم الموارد (kaminari).
- **اختبارات باستخدام RSpec و Shoulda Matchers:** اختبارات وحدات وتكامل باستخدام RSpec مع Shoulda Matchers لتبسيط التأكيدات.
- **تغطية الاختبارات باستخدام SimpleCov:** تحليل تغطية الشيفرة بشكل آلي باستخدام SimpleCov.
- **حذف ناعم باستخدام Discard:** تنفيذ حذف ناعم (soft delete) باستخدام Gem Discard للحفاظ على السجلات في قاعدة البيانات دون حذفها فعلياً.
- **إخفاء البيانات:** تطبيق تقنيات إخفاء البيانات الحساسة.
- **API RESTful:** تطوير API RESTful للتواصل بين الجزء الخلفي والواجهة الأمامية.
- **Swagger:** توثيق API بشكل تلقائي باستخدام Swagger لتسهيل الفهم والاستخدام.
- **Docker:** خيار استخدام Docker للحاويات لتسهيل تطوير ونشر التطبيق.
- **معالجة الصور:** معالجة الصور باستخدام أدوات محددة لمعالجة الوسائط.
- **WebSockets و SSE:** تنفيذ التواصل في الوقت الفعلي باستخدام WebSockets و Server-Sent Events (SSE) لوظائف مثل الدردشة أو التحديثات في الوقت الفعلي.
- **حساب المسافة:** استخدام Gem geocoder لتنفيذ حساب المسافة بالكيلومترات من الموقع التجاري إلى منزل العميل.
- **الخيوط (Threads):** استخدام الخيوط لتحسين التوازي والأداء في العمليات المتوازية.

## إعداد المشروع

### باستخدام Docker

لتشغيل هذا المشروع باستخدام Docker، اتبع الخطوات التالية:

#### المتطلبات الأساسية

تأكد من أنك قد قمت بتثبيت Docker و Docker Compose على جهازك.

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

#### الإعداد

1. قم باستنساخ المستودعات ذات الصلة:

   ```sh
   git clone https://github.com/SamuelRocha91/consumy.git
   git clone https://github.com/SamuelRocha91/seller_application.git
   git clone https://github.com/SamuelRocha91/paymenty.git
   git clone https://github.com/SamuelRocha91/delivery_back.git
   ```

2. قم بتنزيل ملف `docker-compose.yml` لتكوين خدمات Docker اللازمة وضعه في المجلد الجذر حيث تم استنساخ المستودعات:

   - [تنزيل docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

3. في الجذر الخاص بالمشروع، حيث يوجد ملف `docker-compose.yml`، قم بتنفيذ الأمر التالي لبناء وتشغيل الخدمات:

   ```sh
   docker-compose up --build
   ```

4. عند الدخول إلى تطبيق الخلفية في المتصفح، انقر على "RUN PENDING MIGRATES" لإنشاء الترحيلات.

5. يُنصح بدخول حاوية تطبيق الخلفية وتشغيل البيانات الأولية:

   ```sh
   docker exec -it اسمالحاوية /bin/sh 
   rails db:seed
   ```

6. يلزم إعداد متغيرات البيئة في ملف `.env` داخل تطبيق `delivery_back`. مثال:

   ```sh
   JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
   ```

7. يلزم إعداد متغيرات البيئة في ملف `.env.development` داخل تطبيقات `consumy` و `seller`. مثال:

   ```sh
   VITE_BASE_URL=http://localhost:3000
   VITE_X_API_KEY=Z34dqYJ8qBelcmcBfWNuHc5JB/w=
   ```

**ملاحظة** يمكن إنشاء مفاتيح API داخل حاوية الخلفية عبر وحدة التحكم ثم لصقها في ملف `.env`.

**ملاحظة** طريقة أخرى هي إنشاؤها عبر مستخدم لديه دور مطور داخل واجهة الخلفية ونسخها ولصقها في التطبيق المناسب.

**ملاحظة** لا تنسى إعادة تشغيل الحاويات لتحميل متغيرات البيئة.

![مثال على الإعداد](./assets/apikey.gif)

### بدون Docker

لتكوين وتشغيل المشروع محلياً بدون استخدام Docker، اتبع الخطوات التالية:

#### المتطلبات الأساسية

تأكد من أنك قد قمت بتكوين وتشغيل Redis و Sidekiq محلياً. بالإضافة إلى ذلك، قم بتثبيت التبعيات اللازمة لـ R:

```sh
install.packages("FactoMineR")
install.packages("ggplot2")
install.packages("reshape2")
```

#### تثبيت التبعيات

```sh
bundle install
```

#### إعداد قاعدة البيانات

قم بإنشاء قاعدة البيانات وتنفيذ الترحيلات:

```sh
rails db:create
rails db:migrate
```

#### بدء الخادم المحلي

لتشغيل الخادم محلياً:

```sh
rails server
```

#### تشغيل الاختبارات

لتشغيل الاختبارات الآلية:

```sh
bundle exec rspec
```

#### بدء Redis و Sidekiq

تأكد من أن Redis مثبت ويعمل. ابدأ Redis باستخدام الأمر التالي:

```sh
redis-server
```

ثم ابدأ Sidekiq:

```sh
bundle exec sidekiq
```

## مشاريع أخرى


ها هي قائمة المشاريع باللغة العربية:

- 📏 [تطبيق الدقة React](https://github.com/SamuelRocha91/precisionReactApplication/blob/main/README_ar.md) - واجهة تسجيل قياسات الغاز والماء
- 🤖 [واجهة برمجة التطبيقات Node](https://github.com/SamuelRocha91/apiMeasureWaterAndGas/blob/main/README_ar.md) - واجهة برمجة التطبيقات لقياس وتسجيل استهلاك الماء والغاز
