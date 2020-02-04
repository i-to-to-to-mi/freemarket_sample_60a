// プレビューに挿入するHTMLの作成
function buildImage(loadedImageUri){
  var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
      // 画像に編集・削除ボタンをつける
      img.append(btn_wrapper);
      img.find('img').attr({
        src: e.target.result
      })
  return html
};
// 画像を管理するための配列を定義する。
var files_array = [];
// 通常のドラッグオーバイベントを止める。
$('.dropzone-area').on('dragover',function(e){
    e.preventDefault();
});
// ドロップ時のイベントの作成
$('.dropzone-area').on('drop',function(event){
  event.preventDefault();
    // ここで、イベントによって得たファイルを配列で取り込んでいます。
  files = event.dataTransfer.files;
    // 画像のファイルを一つづつ、先ほどの画像管理用の配列に追加する。
  for (var i=0; i<files.length; i++) {
    files_array.push(files[i]);
    var fileReader = new FileReader();
    // ファイルが読み込まれた際に、行う動作を定義する。
    fileReader.onload = function( event ) {
    // 画像のurlを取得します。
    var loadedImageUri = event.target.result;
    // 取得したURLを利用して、ビューにHTMLを挿入する。
    $(buildImage(loadedImageUri,)).appendTo(".dropzone-container preview").trigger("drop");
    };
    // ファイルの読み込みを行う。
    fileReader.readAsDataURL(files[i]);
  }
});

