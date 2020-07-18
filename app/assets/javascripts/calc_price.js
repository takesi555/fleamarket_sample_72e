window.addEventListener('load', function() {

  $(function() {

    $('.number_field__box').on('change', function() {
      let price = $(this).val();
      let fee = Math.floor(price * 0.1);
      let profit = price - fee

      let fee_yen = fee.toLocaleString("jp",{style:"currency",currency:"JPY"});
      let profit_yen = profit.toLocaleString("jp",{style:"currency",currency:"JPY"});
      
      $(".calc_result--fee").html(fee_yen);
      $(".calc_result--profit").html(profit_yen);
    });

  });
});
