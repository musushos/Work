#!/bin/bash

# المسار الرئيسي للمشاريع
BASE_DIR="/home/x/Work"
DEST_DIR="$BASE_DIR/vaxpdeb"

# إنشاء المجلد الوجهة إذا لم يكن موجوداً
mkdir -p "$DEST_DIR"

echo "يبدأ الآن فحص المشاريع والبحث عن حزم .deb..."
echo "------------------------------------------------"

total_copied=0
missing_projects=()

# المرور على جميع المجلدات في المسار
for dir in "$BASE_DIR"/*/; do
    # استخراج اسم المجلد
    dir_name=$(basename "$dir")
    
    # استثناء المجلدات التي لا تعتبر مشاريع (مثل المجلد الوجهة نفسه أو مجلد الفهرس)
    if [ "$dir_name" == "vaxpdeb" ] || [ "$dir_name" == "apps_index" ]; then
        continue
    fi

    # البحث عن أي ملف ينتهي بـ .deb داخل هذا المشروع
    deb_files=$(find "$dir" -type f -name "*.deb")

    if [ -n "$deb_files" ]; then
        # في حال تم إيجاد ملفات .deb، نقوم بنسخها
        for file in $deb_files; do
            cp "$file" "$DEST_DIR/"
            ((total_copied++))
        done
    else
        # في حال لم يتم إيجاد ملفات .deb، نضيف المشروع للقائمة
        missing_projects+=("$dir_name")
    fi
done

echo ""
echo "================================================="
echo "الإحصائيات النهائية:"
echo "================================================="
echo "✅ إجمالي الحزم (.deb) التي تم العثور عليها ونسخها: $total_copied حزمة"
echo "❌ عدد المشاريع التي لا تحتوي على حزم .deb: ${#missing_projects[@]} مشروع"

# عرض المشاريع التي لم يتم العثور فيها على حزم
if [ ${#missing_projects[@]} -gt 0 ]; then
    echo ""
    echo "قائمة المشاريع التي لم يُعثر فيها على حزم .deb:"
    for proj in "${missing_projects[@]}"; do
        echo " - $proj"
    done
fi
