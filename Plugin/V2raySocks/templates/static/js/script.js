var base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
function base64encode(str) {
    var out, i, len;
    var c1, c2, c3;
    len = str.length;
    i = 0;
    out = "";
    while (i < len) {
        c1 = str.charCodeAt(i++) & 0xff;
        if (i == len) {
            out += base64EncodeChars.charAt(c1 >> 2);
            out += base64EncodeChars.charAt((c1 & 0x3) << 4);
            out += "==";
            break;
        }
        c2 = str.charCodeAt(i++);
        if (i == len) {
            out += base64EncodeChars.charAt(c1 >> 2);
            out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
            out += base64EncodeChars.charAt((c2 & 0xF) << 2);
            out += "=";
            break;
        }
        c3 = str.charCodeAt(i++);
        out += base64EncodeChars.charAt(c1 >> 2);
        out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
        out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6));
        out += base64EncodeChars.charAt(c3 & 0x3F);
    }
    return out;
}
$(document).ready(function() {
	jQuery(document).ready(function($) {
		$("button[name='qrcode']").on('click',function() {
			str = $(this).attr('data-params');
            var tcontent = '<div id="qrcode"></div>';
            tcontent += '<script type="text/javascript"> \n';
            tcontent += 'str = "' + str + '"; \n';
            tcontent += 'var element = document.getElementById("qrcode"); \n';
            tcontent += 'var bodyElement = document.body; \n';
            tcontent += 'if(element.lastChild) \n';
            tcontent += 'element.replaceChild(showQRCode(str), element.lastChild); \n';
            tcontent += 'else \n';
            tcontent += 'element.appendChild(showQRCode(str)); \n';
            tcontent += '</script>';
			layer.open({
				type: 1,
				title: $(this).attr('data-type'),
				offset: 'auto',
				closeBtn: 1,
				shadeClose: true,
				content: tcontent
			});
		});
		$("button[name='url']").on('click',function() {
			str = $(this).attr('data-params');
            bty = $(this).attr('data-unit');
            done = $(this).attr('data-done');
            var clipboard = new Clipboard( bty , {
                text: function() {
                    return str;
                }
            });
            clipboard.on('success', function(e) {
                layer.alert(done);
            });
		});
	});
});
