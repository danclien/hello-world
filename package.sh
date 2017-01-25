USER=danclien
APPNAME=$(stack query locals | head -n 1 | head -c -2)
VERSION=$(stack query locals $APPNAME version | cut -d "'" -f 2)

echo Creating Docker image $USER/$APPNAME:$VERSION

mkdir -p dist
stack install --local-bin-path dist

sudo docker build . --tag $USER/$APPNAME:$VERSION
