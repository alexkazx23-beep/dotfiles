function proxy_on
    set -gx http_proxy  http://127.0.0.1:7890
    set -gx https_proxy $http_proxy
    set -gx all_proxy   socks5://127.0.0.1:7891
    
    set -gx HTTP_PROXY  $http_proxy
    set -gx HTTPS_PROXY $https_proxy
    set -gx ALL_PROXY   $all_proxy
    
    echo "终端代理已开启"
end
