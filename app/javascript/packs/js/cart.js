$(function () {
  $(document).on("submit", ".add-to-cart", function (event) {
    event.preventDefault();
    let urlRequest = $(this).attr("action");
    let id = $(this).data("id");
    $.ajax({
      url: urlRequest,
      method: "post",
      data: {
        id: id,
      },
      success: function (data) {
        $(".submit-add-to-cart").removeAttr("disabled");
        if (data.status === 200) {
          let count = data["nav-cart-count"];
          $(".nav-cart-count").text(count);
          toastr.success(data.message);
        } else {
          toastr.error(data.message);
        }
      },
    });
  });
  $(document).on("submit", ".increase", function (event) {
    event.preventDefault();
    let urlRequest = $(this).attr("action");
    let id = $(this).data("id");
    $.ajax({
      url: urlRequest,
      method: "post",
      data: {
        id: id,
      },
      success: function (data) {
        $(".btn-increase").removeAttr("disabled");
        if (data.status === 200) {
          $("#product-count_"+ id).text(data["product-count"]);
          $(".total-price-cart").text(data["total-price-cart"].toLocaleString('it-IT', {style : 'currency', currency : 'VND'}));
          $(".nav-cart-count").text(data["nav-cart-count"]);
          toastr.success(data.message);
        } else {
          toastr.error(data.message);
        }
      },
    });
  });
  $(document).on("submit", ".reduce", function (event) {
    event.preventDefault();
    let urlRequest = $(this).attr("action");
    let id = $(this).data("id");
    $.ajax({
      url: urlRequest,
      method: "post",
      data: {
        id: id,
      },
      success: function (data) {
        $(".btn-reduce").removeAttr("disabled");
        if (data.status === 200) {
          $("#product-count_"+ id).text(data["product-count"]);
          $(".total-price-cart").text(data["total-price-cart"].toLocaleString('it-IT', {style : 'currency', currency : 'VND'}));
          $(".nav-cart-count").text(data["nav-cart-count"]);
          toastr.success(data.message);
        } else {
          toastr.error(data.message);
        }
      },
    });
  });
});
