$(document).on('turbolinks:load', function(){
  var dropzone = $('.dropzone-area');
  var dropzone2 = $('.dropzone-area2');
  var images = [];
  var inputs  =[];
  var input_area = $('.input_area');
  var input_area2 = $('.input_area2');
  var preview = $('#preview');
  var preview2 = $('#preview2');

  // １段目の記述
  $(dropzone).on('change', 'input[type= "file"].upload-image',function(event) {
    event.preventDefault();
    console.log("1")
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    inputs.push($(this));
    var img = $(`<div class= "img_view"><img></div>`);
    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
      img.append(btn_wrapper);
      img.find('img').attr({
        src: e.target.result
      })
    }
    reader.readAsDataURL(file);
    images.push(img);

    // 画像が4枚以下の時は２段目のボックスが開かないようにする
    if(images.length <= 4) {
      $('#preview').empty();
      $.each(images, function(index, image) {
        image.data('image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - ${images.length}))`
      })
      dropzone2.css({
        display: 'none'
      })

// 画像が５枚のとき２段目の枠を出す
  }else if (images.length == 5) {
      $("#preview").empty();
      $.each(images, function(index, image) {
        image.data("image", index);
        preview.append(image);
      });
      // dropzone2 はクラス.dropzone-area2を定義
      dropzone2.css({
        display: "block"
      });
      // dropzone はクラス.dropzone-areaを定義
      dropzone.css({
        display: "none"
      });
      preview2.empty();

  // 画像が６枚以上の時
  }  else if(images.length >= 6) {

    // 配列から６枚目以降の画像を抽出
    var pickup_images = images.slice(5);
    $.each(pickup_images, function(index, image) {
      image.data("image", index + 5);
      preview2.append(image);
      dropzone2.css({
        width: `calc(100% - (100px * ${images.length - 5}))`
      });
    });

      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    } else {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        dropzone.css({
          'width': `calc(100% - (100px * ${images.length}))`
        })
      }
      if(images.length == 4) {
        dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    if(images.length == 10) {
      dropzone2.css({
        display: 'none'
      })
      return;
    }
    var new_image = $(`<input multiple= "multiple" name="product_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
    input_area.prepend(new_image);
  });

  // ２段目ボックスの記述（６枚目以降）
  
  $(dropzone2).on('change', 'input[type= "file"].upload-image2',function(event) {
    event.preventDefault();
    console.log("2")
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    inputs.push($(this));
    var img = $(`<div class= "img_view"><img></div>`);
    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
      img.append(btn_wrapper);
      img.find('img').attr({
        src: e.target.result
      })
    }
    reader.readAsDataURL(file);
    images.push(img);
    
  if(images.length >= 6) {
    var pickup_images = images.slice(5);
    $.each(pickup_images, function(index, image) {
      image.data("image", index + 5);
      preview2.append(image);
      dropzone2.css({
        width: `calc(100% - (100px * ${images.length - 5}))`
      });
    })
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    } else {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview2.append(image);
        })
        dropzone2.css({
          'width': `calc(100% - (100px * ${images.length}))`
        })
      }
    if(images.length == 10) {
      dropzone2.css({
        display: 'none'
      })
      return;
    }
    var new_image = $(`<input multiple= "multiple" name="product_images[image][]" class="upload-image2" data-image= ${images.length} type="file" id="upload-image2">`);
    input_area2.prepend(new_image);
  });
  // 削除の記述
  $(document).on('click', '.delete', function() {
    var target_image = $(this).parent().parent();
    $.each(inputs, function(index, input){
      if ($(this).data('image') == target_image.data('image')){
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
        inputs.splice(num, 1);
        if(inputs.length == 0) {
          $('input[type= "file"].upload-image').attr({
            'data-image': 0
          })
        }
      }
    })
    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
    })
    $.each(inputs, function(index, input) {
      var input = $(this)
      input.attr({
        'data-image': index
      })
      $('input[type= "file"].upload-image:first').after(input)
    })
    // 画像が4枚以下の時は２段目のボックスが開かないようにする
    if(images.length <= 4) {
      dropzone2.css({
        display: 'none'
      })
    }
    if (images.length >= 5) {
      dropzone2.css({
        display: 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
      })
      dropzone2.css({
        'width': `calc(100% - (100px * ${images.length - 5}))`
      })
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
      if(images.length == 8) {
        dropzone2.find('i').replaceWith('<p>ドラッグアンドドロップ <br>またはクリックしてファイルをアップロード</p>')
      }
    } else {
      dropzone.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (100px * ${images.length}))`
      })
    }
    if(images.length == 4) {
      dropzone2.css({
        'display': 'none'
      })
    }
    if(images.length == 9) {
      dropzone2.css({
        'display': 'block'
      })
    }
    if(images.length == 3) {
      dropzone.find('i').replaceWith('<p>ドラッグアンドドロップ<br> またはクリックしてファイルをアップロード</p>')
    }
  })


// // 削除の記述no2
// ビューの見た目ができたのでサーバーの実装側で記述いただきます
});



