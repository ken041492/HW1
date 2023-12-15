import React, { useState } from 'react';
import Col from 'react-bootstrap/Col';
import Card from 'react-bootstrap/Card';
import Button from 'react-bootstrap/Button';
import ProductModal from './ProductModal';

const updateStudent = async (productId, product, newPrice) => {
    let updateProductObj = {
        "id": productId,
        "name": product.name,
        "price": parseInt(newPrice),
        "category_id": product.category_id
    }
    console.log(JSON.stringify(updateProductObj))
    try {
      const response = await fetch(`http://localhost:8080/product/${productId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(updateProductObj),
      });

      if (!response.ok) {
        throw new Error('Update failed');
      }
  
      // 更新成功的處理邏輯，可能需要重新載入數據或執行其他動作
      console.log('Update successful');
    } catch (error) {
      console.error('Error updating product:', error.message);
    }
  };
  
const deleteStudent = async (productId) => {
    try {
        const uri = `http://localhost:8080/product/${productId}`;
        const options = {
          method: 'DELETE',
          headers: new Headers(),
        };
    
        const response = await fetch(uri, options);
    
        if (!response.ok) {
          throw new Error('Delete failed');
        }
    
        console.log('Delete successful');
        // 如果有需要，你可以進一步處理刪除成功後的邏輯
    
      } catch (error) {
        console.error('Error deleting product:', error.message);
        // 在此處理刪除失敗的情況
      }
};

const ProductCard = ({ product, fetchData}) => {
  const [showModal, setShowModal] = useState(false);

  const handleShowModal = () => {
    setShowModal(true);
  };

  const handleHideModal = async() => {
    setShowModal(false);
    await fetchData();
  };

  return (
    <Col md={4} className="mb-4">
      <Card>
        <Card.Body>
          <Card.Title><strong>{product.name}</strong></Card.Title>
          <Card.Text>
            <strong>ID:</strong> {product.id}<br />
            <strong>Price:</strong> ${product.price}<br />
            <strong>Category ID:</strong> {product.category_id}
            <br /><br />
          </Card.Text>
        </Card.Body>
      </Card>
      <ProductModal
        productId={product.id}
        productName={product.name}
        productPrice={product.price}
        onUpdatePrice={(productId, newPrice) => 
            // console.log(`Updating price for product ${productId} to ${newPrice}`)
            updateStudent(productId, product, newPrice)
        }
        show={showModal}
        onHide={handleHideModal}
        fetchData={fetchData}
        onDeleteProduct={(productId) =>
            deleteStudent(productId)
        }
      />
    </Col>
  );
};

export default ProductCard;
