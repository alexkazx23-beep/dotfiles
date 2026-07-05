function proxy_off
    set -e http_proxy https_proxy all_proxy
    set -e HTTP_PROXY HTTPS_PROXY ALL_PROXY
    echo "终端代理已关闭"
end
