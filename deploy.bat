@echo off
flutter build web --base-href /osm/ --release & scp -Cr build\web\* root@backstreets.site:/var/www/html/osm
