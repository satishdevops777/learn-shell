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

while read -r URL
do
        HTTP_CODE=`curl -o /dev/null -s -w "%{http_code}\n" $URL`
        if [ $HTTP_CODE -gt 200 ]; then
                echo "URL is accessible"
        elif [ $HTTP_CODE -eq 301 ];
                echo "URL is  accessible"
        else 
                echo "URL is no accessible"
        fi
done < url.txt


while read -r URL
do
    HTTP_CODE=$(curl --connect-timeout 5 -o /dev/null -s -w "%{http_code}" "$URL")

    case "$HTTP_CODE" in
        200)
            echo "$URL → OK"
            ;;
        301|302)
            echo "$URL → Redirect ($HTTP_CODE)"
            ;;
        000)
            echo "$URL → Connection failed"
            ;;
        *)
            echo "$URL → Error ($HTTP_CODE)"
            ;;
    esac
done < url.txt
