package main

import (
	"go_gin_example/controller"
	"go_gin_example/envconfig"
	"log"

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

func main() {
	server := gin.Default()

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

	// GET /order
	server.GET("/order", controller.GetOrder)
	server.GET("/order/:OrderId", controller.GetOrderById)
	server.GET("/order/:OrderId/item", controller.GetItemByOrderId)

	// GET /item
	server.GET("/item", controller.GetItem) //

	server.POST("/product", controller.CreateProduct)
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
	if err := server.Run(":" + envconfig.GetEnv("PORT")); err != nil {
		log.Fatalln(err.Error())
		return
	}
}
