# development

## requirements

* Adobe Flex SDK http://www.adobe.com/devnet/flex/flex-sdk-download-all.html
* ruby and rake

## setup

Simply unzip the flex SDK somewhere, e.g. /usr/local/flex.

## building

    $ FLEX_HOME=/usr/local/flex rake

Builds and copies to `~/dev/blake/caper/vendor/assets/javascripts/flashcanvas`

You can have the swf copied elsewhere

    $ FLEX_HOME=/usr/local/flex SWF_DEST=/tmp rake

You can build or copy separately

    $ FLEX_HOME/usr/local/flex rake build
    $ SWF_DEST=/tmp rake copy
