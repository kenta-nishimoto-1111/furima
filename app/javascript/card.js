const pay = () => {
  Payjp.setPublicKey("pk_test_21d5a0012b6d7a93b97d85ac");

  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);


    const card = {
      number: formData.get("pay_form[number]"),
      cvc: formData.get("pay_form[cvc]"),
      exp_month: formData.get("pay_form[exp_month]"),
      exp_year: `20${formData.get("pay_form[exp_year]")}`,
    };


    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        // 下記でトークンの情報をフォームに含まれるようにしている
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        // ↪︎ valueは実際に送られる値、nameはその値を示すプロパティ名（params[:name]のように取得できるようになる）,type="hidden"で非表示にしている
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        // ↪︎ フォームの中に作成したinput要素を追加しています
        }
      

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");


      debugger
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);