// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function insertImage(img_url) {  
    window.tinyMCE.execCommand('mceInsertContent', false, "<br/><img src='"+img_url+"'/>");  
   }  
   
function fix_image_size(images,maxW) {
    if(images.length>0){
        Event.observe(window,'load',function() {
            images.each(function(img){
                var w=img.width;
                var h=img.height;
                if(w>maxW){
                    var f=1-((w-maxW)/w);
                    img.title="˜ò?¬d¬Ý­ì©l¤j¤p?¤ù";
                    img.addClassName("magplus");
                    img.onclick=function(){
                        window.open(this.src);
                    };
                    img.width=w*f;
                    img.height=h*f;
                }
            });
        });
    }
}