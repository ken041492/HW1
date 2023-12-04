import React, { useState, useEffect } from 'react';
import Table from 'react-bootstrap/Table';
import { Card, Container, Row, Col } from 'react-bootstrap';
import TextField from '@mui/material/TextField';
// import Button from 'react-bootstrap/Button';

function App() {
  const [data, setData] = useState({
    products: [],
    orders: [],  
    items: [],
    customers: [],
  });

  const [filteredData, setFilteredData] = useState([]);
  const [filterName, setFilterName] = useState("");
  const [filterOrderById, setFilterOrder] = useState([]);
  const [filterCustomerName, setFilterCustomer] = useState("");


  const handleFilter = (orderId) => {
    try {
      
    const filteredOrders = data.items.filter(item => item.order_id === orderId);
    const filterName = filteredOrders.length > 0 ? data.products.filter(product => 
      filteredOrders[0].product_id === product.id): [];
    const filterOrderById = data.orders.filter(order => order.id === orderId);
    const filterCustomer = filterOrderById.length > 0 ? data.customers.filter(customer => 
      filterOrderById[0].customer_id === customer.id) : [];

    setFilterCustomer(filterCustomer[0].name)
    setFilterOrder(filterOrderById)
    setFilterName(filterName);
    setFilteredData(filteredOrders);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };
  
  useEffect(() => {
    // 在組件初次渲染時取得資料
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      // 获取产品数据
    const productResult = await fetch('http://localhost:8080/product');
    const productData = await productResult.json();

    // 获取其他 API 数据
    const orderResult = await fetch('http://localhost:8080/order');
    const orderData = await orderResult.json();

    const itemResult = await fetch('http://localhost:8080/item');
    const itemData = await itemResult.json();

    const customerResult = await fetch('http://localhost:8080/customer');
    const customerData = await customerResult.json();

    console.log(orderData);
    // 设置数据到 state 中
    setData({
      products: productData,
      orders: orderData,
      items: itemData,
      customers: customerData,
      // 添加其他 API 数据的属性...
    });
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };


  const ProductCard = ({ product }) => (
    <Col md={4} className="mb-4">
      <Card>
        <Card.Body>
          <Card.Title><strong>{product.name}</strong></Card.Title>
          <Card.Text>
            <strong>ID:</strong> {product.id}<br />
            <strong>Price:</strong> ${product.price}<br />
            <strong>Category ID:</strong> {product.category_id}
          </Card.Text>
        </Card.Body>
      </Card>
    </Col>
  );

  const ProductList = ({ data }) => (
    <Container className="border p-4">
      <Row>
        {data.map((product) => (
          <ProductCard key={product.id} product={product} />
        ))}
      </Row>
    </Container>
  );

  const OrderListContainer = ({ data }) => (
    <div>
      <h1>訂單列表</h1>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th>ID</th>
            <th>customerId</th>
            <th>isPaid</th>
          </tr>
        </thead>
        <tbody>
          {data.map((order) => (
            <tr key={order.id}>
              <td>{order.id}</td>
              <td>{order.customer_id}</td>
              <td>{order.is_paid ? '已支付' : '未支付'}</td>
            </tr>
          ))}
        </tbody>
      </Table>
    </div>
  );

  const FilterOrderListContainer = ({ data }) => (
    <div>
      <h1>篩選列表</h1>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th>ID</th>
            <th>customerName</th>
            <th>productName</th>
            <th>IsShipped</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item) => (
            <tr key={item.id}>
              <td>{item.id}</td>
              <td>{filterCustomerName}</td>
              <td>{filterName[0].name}</td>
              <td>{item.is_paid ? '已出貨' : '未出貨'}</td>
            </tr>
          ))}
        </tbody>
      </Table>
    </div>
  );


  return (
    <div style={{ textAlign: 'center', marginTop: '20px' }}>
      <h1>商品列表</h1>
      <ProductList data={data.products} />
      <OrderListContainer data={data.orders} />
      <TextField
        label="Order ID"
        variant="outlined"
        onChange={(e) => handleFilter(e.target.value)}
      />
      <FilterOrderListContainer data={filteredData} />
    </div>
  );
}

export default App;