import React, { useState } from 'react';
import { Modal, Button, Form } from 'react-bootstrap';
import { v4 as uuidv4 } from 'uuid';
import axios from 'axios';

const AddProductModal = ({ onAddProduct }) => {
  const [show, setShow] = useState(false);
  const [productName, setProductName] = useState('');
  const [productPrice, setProductPrice] = useState('');

  const handleShow = () => setShow(true);
  const handleClose = () => setShow(false);

  const handleAddProduct = async () => {
    // 在這裡執行添加產品的邏輯
    const newProduct = {
      id: uuidv4(),
      name: productName,
      price: parseInt(productPrice),
      category_id: uuidv4(),
      // 其他屬性...
    };

    // 調用父元件傳遞的函式，將新產品傳遞給父元件
    // onAddProduct(newProduct);

    try {
      // 發送 POST 請求
      await axios.post('http://localhost:8080/product', newProduct);

      // POST 請求成功後，執行 onClose 以關閉 Modal
      // onClose();
      handleClose();
      window.location.reload();
    } catch (error) {
      console.error('Error adding product:', error);
    }

    // 清空表單並關閉Modal
    setProductName('');
    setProductPrice('');
    handleClose();
  };

  return (
    <>
      <Button variant="primary" onClick={handleShow}>
        新增產品
      </Button>

      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>新增產品</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form>
            <Form.Group controlId="productName">
              <Form.Label>產品名稱</Form.Label>
              <Form.Control
                type="text"
                placeholder="輸入產品名稱"
                value={productName}
                onChange={(e) => setProductName(e.target.value)}
              />
            </Form.Group>
            <Form.Group controlId="productPrice">
              <Form.Label>產品價格</Form.Label>
              <Form.Control
                type="number"
                placeholder="輸入產品價格"
                value={productPrice}
                onChange={(e) => setProductPrice(e.target.value)}
              />
            </Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={handleClose}>
            關閉
          </Button>
          <Button variant="primary" onClick={handleAddProduct}>
            新增
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  );
};

export default AddProductModal;
