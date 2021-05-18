window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  // ↪︎金額を入力しているフォームを呼び出している

  priceInput.addEventListener("input", () => {
    // ↪︎そのフォームにあたいが入力された時にイベントを起こすようにしている。

    const inputValue = priceInput.value;
    // ↪︎そのフォームのValueを取得している

    const addTaxDom = document.getElementById("add-tax-price");
    // ↪︎販売手数料を表示する場所のidを取得している

    addTaxDom.innerHTML = Math.floor(inputValue * 0.1 );
    // ↪︎手数料計算

    const addProfitDom = document.getElementById("profit");

    addProfitDom.innerHTML = Math.floor(inputValue * 0.9 );

  })
});