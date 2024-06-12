document.addEventListener("DOMContentLoaded", () => {
  const storeSelect = document.getElementById("order_store_id");
  const orderItemsContainer = document.getElementById("order_items");
  const addOrderItemButton = document.getElementById("add_order_item");
  let index = 0;

  const updateProductOptions = () => {
    const storeId = storeSelect.value;

    fetch(`/stores/${storeId}/products.json`)
      .then(response => response.json())
      .then(data => {
        const productOptions = data.map(product => `<option value="${product.id}" data-price="${product.price}">${product.title}</option>`).join('');
       const allElements = document.querySelectorAll('.order_item-two select');
       const lastElement = allElements[allElements.length - 1];
        lastElement.innerHTML = `<option value="">Selecione um produto</option>${productOptions}`;
      });
  };

  if (storeSelect) {
    storeSelect.addEventListener("change", updateProductOptions);
  }

  const addOrderItem = () => {
    const newOrderItem = document.createElement("div");
    newOrderItem.className = "order_item";
    newOrderItem.innerHTML = `
      <div class="order_item-two">
        <label for="order_order_items_attributes_product_id">Produto</label>
        <select name="order[order_items_attributes][product_id]" class="product_select${index}">
          <option value="">Selecione um produto</option>
        </select>
      </div>
      <div>
        <label for="order_order_items_attributes_amount">Quantidade</label>
        <input type="number" name="order[order_items_attributes][amount]" value="1" min="1">
      </div>
      <div>
        <label for="order_order_items_attributes_price">Preço</label>
        <input type="number" name="order[order_items_attributes][price]" class="price_input" step="0.01" readonly>
      </div>
      <a href="#" class="remove_order_item">Remover</a>
    `;
    orderItemsContainer.appendChild(newOrderItem);
    updateProductOptions()
  };

  if (addOrderItemButton) {
    addOrderItemButton.addEventListener("click", (event) => {
      event.preventDefault();
      addOrderItem();
    });
  }

  orderItemsContainer.addEventListener("click", (event) => {
    if (event.target.classList.contains("remove_order_item")) {
      event.preventDefault();
      event.target.closest(".order_item").remove();
    }
  });

  orderItemsContainer.addEventListener("change", (event) => {
    if (event.target.classList.contains(`product_select${index}`)) {
      const selectedOption = event.target.options[event.target.selectedIndex];
      const priceInput = event.target.closest('.order_item').querySelector('.price_input');
      if (selectedOption && priceInput) {
        priceInput.value = selectedOption.getAttribute('data-price');
      }
    }
  });

  if (storeSelect.value) {
    updateProductOptions();
  }
  index += 1
});
