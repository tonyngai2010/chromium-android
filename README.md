Chromium Patch Overlay（最小改动工作流）

本仓库不包含 Chromium 全量源码，只保存补丁、脚本与文档；真正的源码在 src/ 里通过浅克隆与按需检出。
目标：在同一基线上进行最小化修改，并把改动以补丁的形式分享给同事。

目录结构
.
├─ .gclient                # 与 src 同级（官方推荐布局）
├─ src/                    # 上游源码（独立 git 仓库，不提交到本仓库）
├─ patches/                # 生成/维护的补丁（*.patch）
├─ applied_patches/        # 已应用补丁记录（供脚本回滚/审计）
├─ backup/                 # 应用补丁前的备份（脚本策略）
├─ UA/                     # UA/UA-CH 伪装参数文档或样例
├─ apply_patch.bat         # 一键应用补丁
├─ rollback_patch.bat      # 一键回滚补丁
└─ README.md               # 本说明


情况 A：你已知要修改的文件路径（相对 src/）
示例路径：content/browser/renderer_host/user_agent.cc
优点：下载最少、改动最聚焦；适合“只改一个/少数文件”的场景。

下面命令在 仓库根目录 执行（与 .gclient 同级）。Windows 下可用 PowerShell/CMD，或 Git Bash。
cd D:\Code\chromium-android

:: 1) 取基线（浅抓 + 按需取 blob）
git -C src config core.autocrlf false
git -C src fetch origin main --depth=1 --filter=blob:none
git -C src switch -c work --track origin/main

:: 2) 只检出这条路径（最轻量）
git -C src sparse-checkout init --no-cone
git -C src sparse-checkout set content/browser/renderer_host/user_agent.cc
git -C src sparse-checkout reapply

:: 现在文件已出现在：
:: src\content\browser\renderer_host\user_agent.cc

:: 3) 修改它，然后提交（只提交该文件）
git -C src add content/browser/renderer_host/user_agent.cc
git -C src commit -m "feat: tweak UA in user_agent.cc"

:: 4) 导出补丁到根仓库的 patches/
mkdir patches 2>nul
git -C src format-patch -1 HEAD -o patches

:: （可选）如果只要“纯差异”而不要提交元数据：
:: git -C src diff --staged > patches\my_change.patch


应用 / 回滚（脚本）
应用：apply_patch.bat（通常流程：备份 → git am / git apply → 记录到 applied_patches/）

回滚：rollback_patch.bat（基于 applied_patches/ 的记录恢复）

如果脚本不满足你的需要，也可手动：
git -C src am patches\0001-*.patch 或 git -C src apply patches\my_change.patch

规范与建议

补丁命名：<序号>-<模块>-<简述>.patch，便于排序与检索。

追加更多文件/目录：git -C src sparse-checkout set <path1> <path2> ...

