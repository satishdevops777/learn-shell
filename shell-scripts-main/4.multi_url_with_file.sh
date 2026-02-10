for URL in $(cat url.txt)
do
        HTTP_CODE=`curl -o /dev/null -s -w "%{http_code}\n" $URL`
        if [ $HTTP_CODE -gt 200 ]; then
                echo "URL is accessible"
        elif [ $HTTP_CODE -eq 301 ];
                echo "URL is  accessible"
        else 
                echo "URL is no accessible"
        fi
done
