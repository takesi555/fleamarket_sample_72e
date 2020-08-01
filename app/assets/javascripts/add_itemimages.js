window.addEventListener('load', function() {
  $(function() {
    function buildPreviewboxGroup(image) {
      //インプットで新規追加した画像は"unsaved"
      let html = `<div class="previewbox__group previewbox__group_unsaved">
                    <div>
                      <img src="${image}" class="previewbox__group--img">
                    </div>
                    <div class="previewbox__group--btn">
                      削除
                    </div>
                  </div>`;
      return html;
    }

    function buildImageboxGroup() {
      let html = `<div class="imagebox__group_for_new" >
                    <input class="imagebox__field" 
                            type="file"
                            accept="image/*"
                    </input>
                  </div>`;
      return html;
    }

    $(document).on('change', 'input[type= "file"]', function(e) {

      let reader = new FileReader();  //画像を読み込む（ファイルリーダーオブジェクトをインスタンス化）
      let file = e.target.files[0];   //inputから1つ目のfileを取得
      reader.readAsDataURL(file);     //画像ファイルのURLを取得

      reader.onload = function(e) {
        //preview-------------------------------
        //【新規・編集】previewbox__group_unsavedを後ろから追加
        $('.previewbox').append(buildPreviewboxGroup(e.target.result));

        //input-----------------------------------
        //【新規・編集】データの入ったinputタグ（DB未保存）のクラス名をimagebox__group_unsavedに変更して、imageboxの後ろから追加（非表示）
        $('.imagebox__group_for_new').removeClass('imagebox__group_for_new').addClass('imagebox__group_unsaved').appendTo('.imagebox');
        $('.imagebox__group_unsaved').hide();
        //【新規】画像追加用inputタグを追加
        $('.imagebox').prepend(buildImageboxGroup());

        //（１）と（２）により追加分（＝未保存）のpreviweboxとinputタグのインデックス番号が揃う（削除時に、previewboxのインデックス情報から、削除すべきinputタグが指定できる）
        //【新規】追加分（＝未保存）のpreviewboxについて、changeの都度１から採番・・・（１）
        //管理番号の採番---------------------------
        $('.previewbox__group_unsaved').each(function(i) {
          $(this).attr('data-index_unsaved', (i+1));
        });
        //【新規】追加分（＝未保存）のinputタグについて、changeの都度１から採番・・・（２）
        $('.imagebox__group_unsaved').each(function(i) {
          $(this).attr('data-index_unsaved', (i+1));
          $(this).children('.imagebox__field').attr('name', "item[itemimages_attributes][" + (i+1) + "][image]");
          $(this).children('.imagebox__field').attr('id', 'item_itemimages_attributes_' + (i+1) +'_image');
        });

        //ビューのリセット
        let previewbox_count = $('.previewbox__group').length;
        if (previewbox_count >=1) {
          $('.imagebox__info--comments').css('display', 'none');
        }
        if (previewbox_count == 5) {
          $('.imagebox').css('visibility', 'hidden');
        }
      } 
    });

    $('.previewbox').on('click', '.previewbox__group--btn', function() {

      //【新規】追加分（＝DB未保存）の場合、親要素（previewbox__group_unsaved）のインデックスと同一の親要素（プレビュー）、およびinputタグを削除する
      let targetIndex = $(this).parent().data('index_unsaved');
      $('.previewbox__group_unsaved[data-index_unsaved='+targetIndex+']').remove();
      $('.imagebox__group_unsaved[data-index_unsaved='+targetIndex+']').remove();

      //ビューのリセット
      let previewbox_count = $('.previewbox__group').length;
      if (previewbox_count <= 4) {
        $('.imagebox').css('visibility', 'visible');
      }

    });
  });
});
