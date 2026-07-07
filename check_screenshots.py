import os

def check_screenshots(workspace_dir):
    empty_screenshot_projects = []
    no_screenshot_projects = []
    projects_with_screenshots = {}
    total_images_count = 0

    # امتدادات الصور الشائعة للتحقق منها
    image_extensions = ('.png', '.jpg', '.jpeg', '.gif', '.bmp', '.webp', '.svg')

    try:
        projects = [d for d in os.listdir(workspace_dir) if os.path.isdir(os.path.join(workspace_dir, d))]
    except FileNotFoundError:
        print(f"المسار غير موجود: {workspace_dir}")
        return

    for project in sorted(projects):
        if project.startswith("."): 
            continue
            
        project_path = os.path.join(workspace_dir, project)
        screenshot_dir = os.path.join(project_path, "Screenshot")

        if os.path.exists(screenshot_dir) and os.path.isdir(screenshot_dir):
            files = os.listdir(screenshot_dir)
            if not files:
                empty_screenshot_projects.append(project)
            else:
                # حساب عدد الصور في المجلد
                image_count = sum(1 for f in files if f.lower().endswith(image_extensions))
                if image_count > 0:
                    projects_with_screenshots[project] = image_count
                    total_images_count += image_count
                else:
                    # المجلد يحتوي على ملفات ولكنها ليست صور (أو يمكنك اعتباره فارغاً من الصور)
                    empty_screenshot_projects.append(project + " (يحتوي ملفات أخرى وليست صور)")
        else:
            no_screenshot_projects.append(project)

    print("=== مشاريع تحوي صور في مجلد Screenshot ===")
    if projects_with_screenshots:
        for p, count in projects_with_screenshots.items():
            print(f" - {p}: {count} صورة")
        print(f"\n >>> إجمالي عدد الصور في جميع المشاريع: {total_images_count} صورة <<< \n")
    else:
        print(" (لا يوجد)\n")

    print("=== مشاريع تحوي مجلد Screenshot لكنه فارغ (من الصور) ===")
    if empty_screenshot_projects:
        for p in empty_screenshot_projects:
            print(f" - {p}")
    else:
        print(" (لا يوجد)")

    print("\n=== مشاريع لا تحوي مجلد Screenshot إطلاقاً ===")
    if no_screenshot_projects:
        for p in no_screenshot_projects:
            print(f" - {p}")
    else:
        print(" (لا يوجد)")

if __name__ == "__main__":
    check_screenshots("/home/x/Work")
