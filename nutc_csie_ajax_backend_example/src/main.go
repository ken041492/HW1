package main

import (
	"go_gin_example/controller"
	"go_gin_example/envconfig"
	"log"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"

	_ "github.com/lib/pq"
)

func getUsers(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "GET Users by " + controller.GetUser(),
	})
}

func getDBInfo(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "Port" + envconfig.GetEnv("DB_PORT"),
	})
}

// func CORSMiddleware() {
// 	// CORS 設定
// 	// ref: https://ithelp.ithome.com.tw/articles/10204640
// 	// ref:
// }

func main() {
	server := gin.Default()
	// server.Use(CORSMiddleware())
	//GET /users
	server.GET("/users", getUsers) // 讀取Users

	server.GET("/dbinfo", getDBInfo) // 讀取Users

	//GET /users
	server.GET("/students", controller.GetStudents)                                    // 讀取Students
	server.GET("/students/:StudentId", controller.GetStudentById)                      // 讀取Student
	server.GET("/students/:StudentId/department", controller.GetDepartmentByStudentId) // 讀取Department of Student
	server.GET("/students/:StudentId/courses", controller.GetCoursesByStudentId)       // 讀取Courses of Student
	//Post /users
	server.POST("/students", controller.CreateStudents)
	// GET /product
	server.GET("/product", controller.GetProduct) //
	server.GET("/product/:ProductId", controller.GetProductById)
	server.GET("/product/:ProductId/category", controller.GetCategoryByCategoryId)

	// GET /customer
	server.GET("/customer", controller.GetCustomer) //
	server.GET("/customer/:CustomerId", controller.GetCustomerById)
	server.GET("/customer/:CustomerId/order", controller.GetOrderByCustomerId) //
	// Post /product
	server.POST("/product", controller.CreateProduct)
	// Post /customer
	server.POST("/customer", controller.CreateCustomer)
	// Post /order
	server.POST("/order", controller.CreateOrder)

	// GET /order
	server.GET("/order", controller.GetOrder)
	server.GET("/order/:OrderId", controller.GetOrderById)
	server.GET("/order/:OrderId/item", controller.GetItemByOrderId)

	// Put /order
	server.PUT("/order/:OrderId", controller.UpdateOrderByOrderId)
	// Put /item
	server.PUT("/item/:ItemId", controller.UpdateItemByItemId)
	// GET /item
	server.GET("/item", controller.GetItem) //

	//Post /users
	//put /users
	server.PUT("/students/:StudentId", controller.UpdateStudentById)
	//put /product
	server.PUT("/product/:ProductId", controller.UpdateProductById)
	//put /append courses to student

	server.PUT("/students/:StudentId/courses/:CourseId", controller.StudentSelectCourse)
	server.PUT("/students/:StudentId/courses/:CourseId/txmanually", controller.StudentSelectCourseTransactionManuallyExample)
	server.PUT("/students/:StudentId/courses/:CourseId/txmanuallySP", controller.StudentSelectCourseTransactionManuallyWithSavePointExample)

	//delete /users
	server.DELETE("/students/:StudentId", controller.DeleteStudentById)

	//delete /product
	server.DELETE("/product/:ProductId", controller.DeleteProductById)

	//GET /departments
	server.GET("/departments", controller.GetDepartments)                                   // 讀取Departments
	server.GET("/departments/:DepartmentId", controller.GetDepartmentById)                  // 讀取Department
	server.GET("/departments/:DepartmentId/students", controller.GetStudentsByDepartmentId) // 讀取Students of Department
	//GET /ousers with old method
	server.GET("/ousers", controller.GetUsersOldMethod)            // 讀取Users
	server.GET("/ousers/:UserId", controller.GetUserByIdOldMethod) // 讀取Users
	//GET /courses
	server.GET("/courses", controller.GetCourses)              // 讀取Courses
	server.GET("/courses/:CourseId", controller.GetCourseById) // 讀取Courses

	// 建立 Gin 路由器
	router := gin.Default()

	// 設定 CORS 中間件
	config := cors.DefaultConfig()
	config.AllowOrigins = []string{"http://localhost:3000"} // 允許的前端網址
	router.Use(cors.New(config))

	// 添加路由
	router.GET("/product", controller.GetProduct)
	router.GET("/order", controller.GetOrder)
	router.GET("/customer", controller.GetCustomer)
	router.GET("/customer/:CustomerId", controller.GetCustomerById)
	router.GET("/item", controller.GetItem)

	router.GET("/students", controller.GetStudents)               // 讀取Students
	router.GET("/students/:StudentId", controller.GetStudentById) // 讀取Student

	router.POST("/students", controller.CreateStudents)
	router.PUT("/students/:StudentId", controller.UpdateStudentById)
	router.DELETE("/students/:StudentId", controller.DeleteStudentById)

	router.PUT("/product/:ProductId", controller.UpdateProductById)
	router.DELETE("/product/:ProductId", controller.DeleteProductById)

	router.POST("/product", controller.CreateProduct)
	router.POST("/order", controller.CreateOrder)

	// 啟動服務
	router.Run(":8080")

	if err := server.Run(":" + envconfig.GetEnv("PORT")); err != nil {
		log.Fatalln(err.Error())
		return
	}
}
