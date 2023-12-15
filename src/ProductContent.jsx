import React, { useState } from 'react';
import ProductModal from './ProductModal';

function Product({ id, name, price }) {
  const [productPrice, setProductPrice] = useState(price);

  const handleUpdatePrice = (productId, newPrice) => {
    // 在這裡處理價格更新邏輯，例如發送 API 請求更新後端資料
    console.log(`Updating price for product ${productId} to ${newPrice}`);
    // 更新本地狀態
    setProductPrice(newPrice);
  };

  return (
    <div>
      <h3>{name}</h3>
      <p>價格：{productPrice}</p>
      <ProductModal
        productId={id}
        productName={name}
        productPrice={productPrice}
        onUpdatePrice={handleUpdatePrice}
      />
    </div>
  );
}

export default Product;
