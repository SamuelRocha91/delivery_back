# <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" /> تطبيق التوصيل  <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" />

## 🌐 اللغات
[![Português](https://img.shields.io/badge/Português-green)](https://github.com/SamuelRocha91/delivery_back/blob/main/README.md) 
[![Español](https://img.shields.io/badge/Español-yellow)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md) 
[![English](https://img.shields.io/badge/English-blue)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md) 
[![Русский](https://img.shields.io/badge/Русский-lightgrey)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md) 
[![中文](https://img.shields.io/badge/中文-red)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md) 
[![العربية](https://img.shields.io/badge/العربية-orange)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md)

هذا المستودع هو الجزء الخلفي من تطبيق توصيل مبني على Rails، ويشمل واجهات لإدارة بيانات المستخدمين مع أدوار المدير والمطور.

![مثال على واجهة المدير](./assets/admin.gif)

---

<details>
  <summary><strong>🔗 مستودعات ذات صلة</strong></summary>

  - 🛒 [تطبيق المستهلك](https://github.com/SamuelRocha91/consumy/blob/main/README_ar.md) - تطبيق مخصص للمستهلكين
  - 👨‍💼 [تطبيق البائع](https://github.com/SamuelRocha91/seller_application/blob/main/README_ar.md) - تطبيق مخصص للبائعين
  - 💲 [API الدفع](https://github.com/SamuelRocha91/paymenty/blob/main/README_ar.md) - API للدفع

</details>

---

## <h2>📚 المفاهيم والمكتبات المستخدمة</h2>

<details>
  <summary><strong>🔍 انقر للتوسيع لمزيد من التفاصيل حول المكتبات والمفاهيم</strong></summary>

- **المعالجة الخلفية**: استخدام **Sidekiq** لمعالجة المهام غير المتزامنة. **Redis** تُستخدم كقائمة انتظار لتخزين هذه المهام.
  
- **التقسيم**: استخدام مكتبة **Kaminari** لتنفيذ تقسيم قائمة الموارد.

- **اختبارات RSpec وShoulda Matchers**: كتابة اختبارات وحدات واختبارات تكامل واختبارات وظيفية باستخدام **RSpec**.

- **تغطية الاختبارات باستخدام SimpleCov**: دمج مكتبة **SimpleCov** لتحليل تغطية الشيفرة.

- **الحذف الناعم باستخدام Discard**: تنفيذ الحذف الناعم باستخدام مكتبة **Discard**.

- **Bullet لكشف استعلامات N+1**: استخدام مكتبة **Bullet** لاكتشاف ومنع مشاكل الأداء مثل استعلامات **N+1**.

- **إخفاء البيانات**: تطبيق طرق لإخفاء البيانات لحماية البيانات الحساسة والامتثال لقوانين حماية البيانات مثل **LGPD**.

- **API RESTful**: تطوير **RESTful API**، اتباع مبادئ الهندسة البرمجية لضمان التواصل الفعال بين الجزء الخلفي والجزء الأمامي.

- **Swagger**: استخدام مكتبة **Rswag** (المبنية على Swagger) لتوليد وثائق API تلقائيًا.

- **Docker**: دعم استخدام **Docker** للتشغيل في حاويات، مما يسهل عملية التطوير والاختبار والنشر.

- **معالجة الصور**: استخدام مكتبة **ImageProcessing** لمعالجة الصور مثل تغيير الحجم والضغط.

- **WebSockets وSSE**: استخدام **WebSockets** لتنفيذ الاتصال في الوقت الحقيقي.

- **حساب المسافة**: استخدام مكتبة **Geocoder** لحساب المسافة بين العملاء والأعمال.

- **التدفق**: استخدام **التدفق** لتحسين توازي الأداء عند تنفيذ العمليات المتوازية.

- **إدارة الجلسات والتحقق من الهوية**: استخدام **Devise** للتحقق من هوية المستخدمين والتحقق من الهوية عبر **JWT**.

- **إدارة CORS**: استخدام مكتبة **rack-cors** لإدارة أذونات **CORS**.

- **آلات الحالة باستخدام state machine**: استخدام مكتبة **state_machines-activerecord** لتنفيذ آلات الحالة في نماذج ActiveRecord.

- **Faraday للتفاعل مع واجهات API الخارجية**: استخدام مكتبة **Faraday** للاندماج مع الخدمات الخارجية.

- **أتمتة المهام وDevOps**: دعم هيكل **DevOps** باستخدام أدوات مثل **Sidekiq** و**Docker**.

</details>

---

## <h2>⚙️ إعداد المشروع</h2>

<details>
  <summary><strong>🛠️ باستخدام Docker</strong></summary>

  ### المتطلبات الأساسية

  - تأكد من تثبيت Docker وDocker Compose على جهاز الكمبيوتر الخاص بك.
  - [Docker](https://docs.docker.com/get-docker/)
  - [Docker Compose](https://docs.docker.com/compose/install/)

  ### الإعداد

  1. استنساخ المستودعات ذات الصلة:

     ```
     git clone https://github.com/SamuelRocha91/consumy.git
     git clone https://github.com/SamuelRocha91/seller_application.git
     git clone https://github.com/SamuelRocha91/paymenty.git
     git clone https://github.com/SamuelRocha91/delivery_back.git
     ```

  2. تحميل ملف `docker-compose.yml`:

     - [تحميل docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

  3. تشغيل الأوامر التالية في دليل المشروع الجذري:

     ```sh
     docker-compose up --build
     ```

  4. انقر على "تشغيل الهجرات المعلقة" في تطبيق الجزء الخلفي.

  5. ادخل حاوية الجزء الخلفي وقم بتشغيل البذور:

     ```sh
     docker exec -it backendContainerName /bin/sh 
     rails db:seed
     ```

  6. إعداد متغيرات البيئة:

     ```sh
     JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
     ```

  7. أعد تشغيل الحاويات لتحميل المتغيرات.

</details>

<details>
  <summary><strong>🛠️ بدون استخدام Docker</strong></summary>

  ### المتطلبات الأساسية

  - تأكد من إعداد Redis وSidekiq وتشغيلهما على جهاز الكمبيوتر المحلي الخاص بك.
  
  - تثبيت تبعيات R:

     ```sh
     install.packages("FactoMineR")
     install.packages("ggplot2")
     install.packages("reshape2")
     ```

  ### تثبيت التبعيات

  ```sh
  bundle install
  ```

  ### إعداد قاعدة البيانات

  إنشاء قاعدة بيانات وتشغيل الهجرات:

  ```sh
  rails db:create
  rails db:migrate
  ```

  ### بدء الخادم المحلي

  ```sh
  rails server
  ```

  ### تشغيل الاختبارات

  ```sh
  bundle exec rspec
  ```

  ### بدء Redis وSidekiq

  ```sh
  redis-server
  bundle exec sidekiq
  ```

</details>

---

<details>
  <summary><strong>📝 مشاريع أخرى</strong></summary>

  - 📏 [تطبيق Precision (React)](https://github.com/SamuelRocha91/precisionReactApplication/blob/main/README_ar.md) - واجهة لتسجيل قياسات المياه والغاز
  - 🤖 [API قياس](https://github.com/SamuelRocha91/apiMeasureWaterAndGas/blob/main/README_ar.md) - API لقياس وتسجيل الاستهلاك
</details>
