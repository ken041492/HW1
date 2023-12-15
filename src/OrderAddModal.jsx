import React, { useState } from 'react';
import { Modal, Button, Form } from 'react-bootstrap';
import { v4 as uuidv4, parse as uuidFromString } from 'uuid';
import axios from 'axios';


const AddOrderModal = ({ onAddProduct }) => {
    const [show, setShow] = useState(false);
    const [orderId, setOrderId] = useState('');
    const [orderIsPaid, setOrderIspaid] = useState('');
  
    const handleShow = () => setShow(true);
    const handleClose = () => setShow(false);
  
    const handleAddOrder = async () => {
      // 在這裡執行添加產品的邏輯
      const newOrder = {
        id: uuidv4(),
        customer_id: orderId,
        is_paid: Boolean(orderIsPaid),
        // 其他屬性...
      };
  
      // 調用父元件傳遞的函式，將新產品傳遞給父元件
      // onAddProduct(newProduct);
  
      try {
        // 發送 POST 請求
        await axios.post('http://localhost:8080/order', newOrder);
  
        // POST 請求成功後，執行 onClose 以關閉 Modal
        // onClose();
        handleClose();
        window.location.reload();
      } catch (error) {
        console.error('Error adding product:', error);
      }
      // 清空表單並關閉Modal
      setOrderId('');
      setOrderIspaid('');
      handleClose();
    };
  
    return (
      <>
        <Button variant="primary" onClick={handleShow}>
          新增訂單
        </Button>
  
        <Modal show={show} onHide={handleClose}>
          <Modal.Header closeButton>
            <Modal.Title>新增訂單</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <Form>
              <Form.Group controlId="productName">
                <Form.Label>顧客ID</Form.Label>
                <Form.Control
                  type="uuid"
                  placeholder="輸入顧客ID"
                  value={orderId}
                  onChange={(e) => setOrderId(e.target.value)}
                />
              </Form.Group>
              <Form.Group controlId="productPrice">
                <Form.Label>已結帳</Form.Label>
                <Form.Control
                  type="boolean"
                  placeholder="輸入true/false"
                  value={orderIsPaid}
                  onChange={(e) => setOrderIspaid(e.target.value)}
                />
              </Form.Group>
            </Form>
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={handleClose}>
              關閉
            </Button>
            <Button variant="primary" onClick={handleAddOrder}>
              新增
            </Button>
          </Modal.Footer>
        </Modal>
      </>
    );
  };
  
  export default AddOrderModal;
  