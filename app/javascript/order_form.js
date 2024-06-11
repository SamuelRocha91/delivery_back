document.addEventListener("DOMContentLoaded", () => {
  const addOrderItemButton = document.getElementById("add_order_item");
  const orderItemsContainer = document.getElementById("order_items");

  addOrderItemButton.addEventListener("click", (event) => {
    event.preventDefault();
    const newOrderItem = document.createElement("div");
    newOrderItem.innerHTML = `
      <div class="order_item">
        <div>
          <label for="order_order_items_attributes_new_product_id">Produto</label>
          <select name="order[order_items_attributes][new][product_id]" id="order_order_items_attributes_new_product_id">
            ${orderItemsContainer.dataset.products}
          </select>
        </div>
        <div>
          <label for="order_order_items_attributes_new_amount">Quantidade</label>
          <input type="number" name="order[order_items_attributes][new][amount]" id="order_order_items_attributes_new_amount" value="1" min="1">
        </div>
        <div>
          <label for="order_order_items_attributes_new_price">Preço</label>
          <input type="number" name="order[order_items_attributes][new][price]" id="order_order_items_attributes_new_price" step="0.01">
        </div>
        <a href="#" class="remove_order_item">Remover</a>
      </div>
    `;
    orderItemsContainer.appendChild(newOrderItem);
  });

  orderItemsContainer.addEventListener("click", (event) => {
    if (event.target.classList.contains("remove_order_item")) {
      event.preventDefault();
      event.target.closest(".order_item").remove();
    }
  });
});
