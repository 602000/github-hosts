function IPv4 ($domain = "github.com") {
    # 判断参数
    if ($domain -is [array]) {
        $domains = $domain
        $domain = $domain[0]
    }
    else {
        $domains = @()
    }
    # 解析域名
    $domainArray = $domain -split "\."
    if ($domainArray.Count -gt 2) {
        $baseDomain = ($domainArray[$domainArray.Count - 2], $domainArray[$domainArray.Count - 1]) -join "."
        $ipAddress = ([regex]"(?<=IPv4 Addresses</th><td><ul class=""comma-separated""><li>)(.*?)(?=</li>)").
        Matches((Invoke-WebRequest https://$baseDomain.ipaddress.com/$domain).Content).Value
    }
    else {
        $ipAddress = ([regex]"(?<=IPv4 Addresses</th><td><ul class=""comma-separated""><li>)(.*?)(?=</li>)").
        Matches((Invoke-WebRequest https://$domain.ipaddress.com).Content).Value
    }
    # 判断数量
    if ($ipAddress.Count -gt 1) {
        $ip = $ipAddress[0]
    }
    elseif ($ipAddress.Count -gt 0) {
        $ip = $ipAddress
    }
    else {
        return
    }
    # 返回结果
    if ($domains.Count -gt 0) {
        $ret = @()
        $ret += ($ip, $domain -join "    ")
        for ($i = 1; $i -lt $domains.Count; $i++) {
            $ret += $ip, $domains[$i] -join "    "
        }
        return $ret
    }
    else {
        return $ip, $domain -join "    "
    }
}

Write-Output "# Added by github-hosts"
IPv4("github.com")
IPv4("gist.github.com")
IPv4("github.global.ssl.fastly.net")
IPv4("assets-cdn.github.com")
IPv4("api.github.com")
IPv4("codeload.github.com")
IPv4("desktop.githubusercontent.com")
IPv4("github.map.fastly.net")
IPv4("raw.githubusercontent.com",
    "cloud.githubusercontent.com",
    "camo.githubusercontent.com",
    "user-images.githubusercontent.com",
    "desktop.githubusercontent.com",
    "avatars0.githubusercontent.com",
    "avatars1.githubusercontent.com",
    "avatars2.githubusercontent.com",
    "avatars3.githubusercontent.com",
    "avatars4.githubusercontent.com",
    "avatars5.githubusercontent.com",
    "avatars6.githubusercontent.com",
    "avatars7.githubusercontent.com",
    "avatars8.githubusercontent.com"
)
Write-Output "# End of section"
