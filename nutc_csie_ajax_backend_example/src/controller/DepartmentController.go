package controller

import (
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type Department struct {
	Id        uuid.UUID `json:"id"`
	Name      string    `json:"name"`
	ShortName string    `json:"short_name"`
}

type Category struct {
	Id   uuid.UUID `json:"id"`
	Name string    `json:"name"`
}

func GetDepartments(c *gin.Context) {

	db := connectDB()

	var departments []*Department

	db.Find(&departments)

	closeDB(db)
	c.JSON(200, departments)

}

func GetCategory(c *gin.Context) {

	db := connectDB()

	var categorys []*Category

	db.Find(&categorys)

	closeDB(db)
	c.JSON(200, categorys)
}

// func GetCustomer(c *gin.Context) {

// 	db := connectDB()

// 	var customer []*Customer

// 	db.Find(&customer)

// 	closeDB(db)
// 	c.JSON(200, customer)
// }

func GetDepartmentById(c *gin.Context) {
	db := connectDB()
	var department *Department
	db.Where("id = $1", c.Param("DepartmentId")).Take(&department)

	closeDB(db)
	c.JSON(200, department)
}

func GetCategoryById(c *gin.Context) {
	db := connectDB()
	var category *Category
	db.Where("id = $1", c.Param("CategoryId")).Take(&category)

	closeDB(db)
	c.JSON(200, category)
}

func GetStudentsByDepartmentId(c *gin.Context) {
	db := connectDB()
	var students []*Student
	db.Where("department_id = $1", c.Param("DepartmentId")).Find(&students)

	closeDB(db)
	c.JSON(200, students)
}

func GetProductByCategoryId(c *gin.Context) {
	db := connectDB()
	var category []*Category
	db.Where("category_id = $1", c.Param("CategoryId")).Find(&category)

	closeDB(db)
	c.JSON(200, category)
}
