import React, { useState } from 'react';
import { Button, Modal } from 'react-bootstrap';

function ProductModal({ productId, productName, productPrice, onUpdatePrice, fetchData, onDeleteProduct }) {
  const [show, setShow] = useState(false);
  const [newPrice, setNewPrice] = useState('');

  const handleShow = () => setShow(true);
  const handleClose = () => setShow(false);

  const handleUpdatePrice = async() => {
    try {
        // 處理價格更新邏輯，然後呼叫父元件的 onUpdatePrice 函式
        await onUpdatePrice(productId, newPrice);
        // 關閉視窗
        handleClose();
        // 重新整理頁面
        window.location.reload();
      } catch (error) {
        console.error('Error updating price and reloading page:', error);
      }
  };
  const handleDelete = async() => {
    try {
        // 處理價格更新邏輯，然後呼叫父元件的 onUpdatePrice 函式
        await onDeleteProduct(productId);
        // 關閉視窗
        handleClose();
        // 重新整理頁面
        window.location.reload();
      } catch (error) {
        console.error('Error updating price and reloading page:', error);
      }
  };

  return (
    <>
      <Button variant="primary" onClick={handleShow}>
        調整
      </Button>
    
      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>修改價格 - {productName}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <label htmlFor="newPrice">新價格：</label>
          <input
            type="text"
            id="newPrice"
            value={newPrice}
            onChange={(e) => setNewPrice(e.target.value)}
          />
        </Modal.Body>
        <Modal.Footer>
            <Button variant="danger" onClick={handleDelete}>
            刪除
            </Button>
          <Button variant="secondary" onClick={handleClose}>
            關閉
          </Button>
          <Button variant="primary" onClick={handleUpdatePrice}>
            儲存修改
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  );
}

export default ProductModal;
