$(function() {
  // keyup:引数にobjectオブジェクトを設定することで、実行するfunctionにデータを渡す
  $("#price").keyup(function(){
    //WEBインスタンスの入力値を取得（numA）
    var price = $('input[name=price]').val();
    
    //parseIntで文字列を数値に変換
    price = parseInt(price);
   
    //入力値が数値では無い場合の処理
    if(!price){
      //計算結果表示のinput内を削除
      $('input[name=margin-price]').val('-');
      $('input[name=profit-price]').val('-');
      return false;
    };
   
    if(price < 300){
      $('input[name=margin-price]').val('-');
      $('input[name=profit-price]').val('-');
      return false;
    };

    if(price > 9999999){
      $('input[name=margin-price]').val('-');
      $('input[name=profit-price]').val('-');
      return false;
    };

    $('input[name=margin-price]').val(price * 0.1);
    $('input[name=profit-price]').val(price * 0.9);
  });
});