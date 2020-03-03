// こちら実際の商品出品では使用していません。エラーが出るため削除予定のものでした
// 実際はimage_upload.jsというファイルを使用しています。
// 今後使用予定ございましたら修正お願いいたします。
// 不要ということで敷いたら削除いただけますでしょうか。
// よろしくお願いいたします。


$(function() {
  $('.liked-items__sliders').slick({
    slidesToShow: 6,
    arrow: true,
    slidesToScroll: 6,
    variableWidth: true,
    centerMode: false,
    centerPadding: '0%',
  });
});

$(document).on('turbolinks:load', ()=> {
  let drop_file = null;
  $('.drop-upload').on('drop', (e) => {
    console.log("maama")
    e.preventDefault();
    // ドロップファイルを記憶
    drop_file = e.originalEvent.dataTransfer.files[0];

    // プレビュー
    const reader = new FileReader();
    $image_item = $(e.target).find('.preview');
    reader.onload = (e) => {
      $image_item.html($('<img>').attr('src', e.target.result));
    }
    reader.readAsDataURL(drop_file);
  })

  // ドロップフォーム以外にドロップされたときページが画像になるのを防ぐ
  $(document).on('drop', (e) => {
    e.stopPropagation();
    e.preventDefault();
  });
  $(document).on('dragenter', (e) => {
    e.stopPropagation();
    e.preventDefault();
  });
  $(document).on('dragover', (e) => {
    e.stopPropagation();
    e.preventDefault();
  });

  
  // 下↓の部分、クレジットカード登録と削除の部分で、
  // submitボタンを押すときに発火してしまい、
  // 修正方法がすぐにはわからなかったので
  // 取り急ぎコメントアウトさせていただきました。
  // またご相談させてください。
  
  // ここから
  // 送信ボタンがおされたとき
  // $('form').on('submit', (e) => {
  //   // console.log("imtejs_form")
  //   // console.log(drop_file); // file オブジェクト
  //   try {
  //     const form_data = new FormData( $(e.target).get()[0] );

  //     // ファイルが選択されてなかったらドロップファイルを送信
  //     if(!$('[type="file"]').val()) {
  //       $(e.target).find('[type="file"]').get()[0].files = e.originalEvent.dataTransfer.files;
  //       form_data.append($(e).attr('name'), drop_file);
  //     }

  //     // ここでform_data を submit したい
  //   } catch(e) {}
  //   return false;
  // });
  // ここまで
  
// -# ここでドロップボックス終了
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="product[images_attributes][${num}][src]"
                    id="product_images_attributes_${num}_src"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $('#image-box').on('change', '.js-file', function(e) {

    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});


