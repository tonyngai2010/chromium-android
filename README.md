情况 A：你已经知道要改的文件路径（相对 src/）
例：content/browser/renderer_host/user_agent.cc


cd D:\Code\chromium-android

:: 1) 取基线
git -C src config core.autocrlf false
git -C src fetch origin main --depth=1 --filter=blob:none
git -C src switch -c work --track origin/main

:: 2) 只检出这条路径（最轻量）
git -C src sparse-checkout init --no-cone
git -C src sparse-checkout set content/browser/renderer_host/user_agent.cc
git -C src sparse-checkout reapply

:: 现在文件已出现在 src\content\browser\renderer_host\user_agent.cc
:: 3) 修改它，然后提交
git -C src add content/browser/renderer_host/user_agent.cc
git -C src commit -m "feat: tweak UA in user_agent.cc"

:: 4) 生成补丁到根仓库
mkdir patches 2>nul
git -C src format-patch -1 HEAD -o patches
:: 或者（不保留提交元数据的简单补丁）：
:: git -C src diff --staged > patches\my_change.patch
