# Port
Close the remote port
1. 在桌面桌下角搜索框里输入powershell,以管理员身份运行
2. 把powershell切换到脚本所在的目录
3. 输入./blockport.ps1并回车,将自动在防火墙的出入站规则里禁用容易暴露敏感信息或易被利用的远程端口
4. 输入./inspect.ps1检查禁用规则是否生效
---------------------------------------------------------------------------------------------------
1. Type powershell in the search box and run it as an administrator

2. Switch powershell to the script directory

3. Enter./blockport.ps1 and press enter to automatically disable remote ports that expose sensitive information or are easily exploited in the firewall's access rules

4. Enter./inspect.ps1 to check whether the rule takes effect
-----------------------------------------------------------------------------------------------------------------------
如果提示输入错误或者权限不足,请输入(If an error message is displayed or the permission is insufficient, enter it):

Set-ExecutionPolicy

回车后输入Y确认

Press Enter and enter Y to confirm

