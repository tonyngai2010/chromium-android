# 项目规则 - Chromium Android 分辨率伪装

1. 必须遵循任务块中给定的“搜索锚点 + 插入/替换代码”方式进行修改，禁止全文件替换。
2. 文件路径必须基于 `src/` 根目录，严格与任务块一致。
3. 在 REPORT 中必须输出：
   - changed_files: 文件路径、增加/删除行数、匹配到的锚点
   - build: GN args、target、构建是否成功、生成的 APK 路径
   - quick_checks: 包含 screen/devicePixelRatio/innerWidth/innerHeight 等运行时检查值
   - errors: 如果匹配失败或构建失败，详细说明原因
4. 所有与屏幕信息相关的修改（ScreenInfo、viewport、DPR）必须保持一致性，防止 bowserscan 检测出真实值。
5. 构建必须使用以下默认 GN args（任务块可覆盖）：
   ```gn
   is_debug=false
   is_official_build=false
   target_os="android"
   target_cpu="arm64"
   enable_nacl=false
   symbol_level=1

   - 1.
分层思考 ：

- API层：JavaScript可访问的screen相关API
- 渲染层：实际的viewport和显示尺寸
- 系统层：Android系统UI
- 2.
全面测试 ：

- 不仅测试API返回值
- 还要测试实际显示效果
- 验证用户体验是否符合预期
- 3.
深入理解代码 ：

- 每个字段的具体作用
- 修改后的实际影响范围
- 是否符合"API伪装+渲染保真"的目标