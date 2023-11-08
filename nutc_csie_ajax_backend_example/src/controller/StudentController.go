package controller

import (
	//"go_gin_example/model"

	"fmt"
	"go_gin_example/envconfig"
	"log"

	_ "github.com/GoogleCloudPlatform/cloudsql-proxy/proxy/dialers/postgres"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
	"gorm.io/gorm/logger"
)

type Student struct {
	Id           uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"  json:"id"`
	FirstName    string    `json:"first_name"`
	LastName     string    `json:"last_name"`
	StudentId    string    `gorm:"index:idx_student_id,unique" json:"student_id"`
	DepartmentId uuid.UUID `gorm:"foreignKey" json:"department_id"`
	//Courses    []Course    `gorm:"many2many:student_course;"`
}

type Product struct {
	Id          uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"  json:"id"`
	Name        string    `json:"name"`
	Price       int       `json:"price"`
	Category_id uuid.UUID `gorm:"foreignKey" json:"category_id"`
}

type Customer struct {
	Id   uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"  json:"id"`
	Name string    `json:"name"`
}

type Order struct {
	Id          uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"  json:"id"`
	Customer_id uuid.UUID `gorm:"foreignKey" json:"customer_id"`
	Is_paid     bool      `json:"is_paid"`
}

type Item struct {
	Id         uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"  json:"id"`
	Order_id   uuid.UUID `gorm:"foreignKey" json:"order_id"`
	Product_id uuid.UUID `gorm:"foreignKey" json:"product_id"`
	Is_shipped bool      `json:"Is_shipped"`
}

type StudentWithDepartment struct {
	Student
	// Department represents the department of a student.
	Department *Department `json:"department,omitempty"`
}

type ProductWithCategory struct {
	Product
	Category *Category `json:"category,omitempty"`
}

type CustomerWithOrder struct {
	Customer
	Order *Order `json:"order,omitempty"`
}

func (CustomerWithOrder) TableName() string {
	return "customer" // 指定你的表格名稱
}

func (StudentWithDepartment) TableName() string {
	return "students"
}

func (ProductWithCategory) TableName() string {
	return "product"
}

type StudentWithCourses struct {
	Student
	Courses []Course `gorm:"many2many:student_course;joinForeignKey:student_id"`
}

func (StudentWithCourses) TableName() string {
	return "students"
}

type StudentWithAll struct {
	Student
	// Department represents the department of a student.
	Department *Department `json:"department,omitempty"`
	Courses    []Course    `gorm:"many2many:student_course;joinForeignKey:student_id"`
}

type ProductWithAll struct {
	Product
	Category *Category `json:"category,omitempty"`
}

type CustomerWithAll struct {
	Customer
}

type OrderWithAll struct {
	Order
}

type ItemWithAll struct {
	Item
}

func (StudentWithAll) TableName() string {
	return "students"
}

func (ProductWithAll) TableName() string {
	return "product"
}

func (CustomerWithAll) TableName() string {
	return "customer" // 指定你的表格名稱
}

func (OrderWithAll) TableName() string {
	return "order" // 指定你的表格名稱
}

func (ItemWithAll) TableName() string {
	return "item" // 指定你的表格名稱
}

type StudentCourseSelection struct {
	Id uuid.UUID `gorm:"primaryKey;type:uuid;default:gen_random_uuid()"  json:"id"`

	StudentId uuid.UUID `gorm:"unique,composite:student_course_unique_constraint" json:"student_id"`
	CourseId  uuid.UUID `gorm:"unique,composite:student_course_unique_constraint" json:"course_id"`
}

func (StudentCourseSelection) TableName() string {
	return "student_course"
}

func CreateStudents(c *gin.Context) {
	db := connectDB()
	var student *Student
	c.BindJSON(&student)

	result := db.Create(&student)
	if result.Error != nil {
		log.Println(result.Error)

		c.JSON(500, gin.H{
			"message": "Create student failed with error: " + result.Error.Error(),
		})
		closeDB(db)
		return
	}

	closeDB(db)
	c.JSON(200, student)
}

func CreateProduct(c *gin.Context) {
	db := connectDB()
	var product *Product
	c.BindJSON(&product)

	result := db.Create(&product)
	if result.Error != nil {
		log.Println(result.Error)

		c.JSON(500, gin.H{
			"message": "Create product failed with error: " + result.Error.Error(),
		})
		closeDB(db)
		return
	}

	closeDB(db)
	c.JSON(200, product)
}

func CreateCustomer(c *gin.Context) {
	db := connectDB()
	var customer *Customer
	c.BindJSON(&customer)

	result := db.Create(&customer)
	if result.Error != nil {
		log.Println(result.Error)

		c.JSON(500, gin.H{
			"message": "Create customer failed with error: " + result.Error.Error(),
		})
		closeDB(db)
		return
	}

	closeDB(db)
	c.JSON(200, customer)
}

func CreateOrder(c *gin.Context) {
	db := connectDB()
	var order *Order
	c.BindJSON(&order)

	result := db.Create(&order)
	if result.Error != nil {
		log.Println(result.Error)

		c.JSON(500, gin.H{
			"message": "Create order failed with error: " + result.Error.Error(),
		})
		closeDB(db)
		return
	}

	closeDB(db)
	c.JSON(200, order)
}

func UpdateStudentById(c *gin.Context) {
	db := connectDB()
	var student *Student

	queryResult := db.Where("id = $1", c.Param("StudentId")).Take(&student)
	if queryResult.Error != nil {
		log.Println(queryResult.Error)
		c.JSON(500, gin.H{
			"message": "Update student failed with error: " + queryResult.Error.Error(),
		})
		closeDB(db)
		return
	}
	var studentBody *Student

	c.BindJSON(&studentBody)
	studentBody.Id = student.Id

	result := db.Model(&student).Where("id = ?", student.Id).Updates(studentBody)

	if result.Error != nil {
		log.Println(result.Error)

		c.JSON(500, gin.H{
			"message": "Update student failed with error: " + result.Error.Error(),
		})

		closeDB(db)
		return
	}

	closeDB(db)
	c.JSON(200, gin.H{
		"message": "Update students Susseccfully",
	})
}

func UpdateProductById(c *gin.Context) {
	db := connectDB()
	var product *Product

	queryResult := db.Where("id = $1", c.Param("Category_id")).Take(&product)
	if queryResult.Error != nil {
		log.Println(queryResult.Error)
		c.JSON(500, gin.H{
			"message": "Update product failed with error: " + queryResult.Error.Error(),
		})
		closeDB(db)
		return
	}
	var productBody *Product

	c.BindJSON(&productBody)
	productBody.Id = product.Id

	result := db.Model(&product).Where("id = ?", product.Id).Updates(productBody)

	if result.Error != nil {
		log.Println(result.Error)

		c.JSON(500, gin.H{
			"message": "Update product failed with error: " + result.Error.Error(),
		})

		closeDB(db)
		return
	}

	closeDB(db)
	c.JSON(200, gin.H{
		"message": "Update product Susseccfully",
	})
}

func DeleteStudentById(c *gin.Context) {
	db := connectDB()
	var student *Student

	queryResult := db.Where("id = $1", c.Param("StudentId")).Take(&student)
	if queryResult.Error != nil {
		log.Println(queryResult.Error)
		c.JSON(500, gin.H{
			"message": "Delete student failed with error: " + queryResult.Error.Error(),
		})
		closeDB(db)
		return
	}

	result := db.Delete(&student)

	if result.Error != nil {
		log.Println(result.Error)

		c.JSON(500, gin.H{
			"message": "Delete student failed with error: " + result.Error.Error(),
		})

		closeDB(db)
		return
	}

	closeDB(db)
	c.JSON(200, gin.H{
		"message": "Delete students Susseccfully",
	})
}
func GetStudents(c *gin.Context) {
	lastName := c.Query("last_name")
	firstName := c.Query("first_name")
	studentId := c.Query("student_id")

	db := connectDB()
	var students []*StudentWithAll
	if lastName != "" && firstName != "" {

		log.Println("lastName: " + lastName)
		log.Println("firstName: " + firstName)
		db.Preload(clause.Associations).Where("last_name = $1 AND first_name = $2 ", lastName, firstName).Find(&students)
	} else if lastName != "" {
		log.Println("lastName: " + lastName)
		db.Preload(clause.Associations).Where("last_name = $1", lastName).Find(&students)
	} else if firstName != "" {
		log.Println("firstName: " + firstName)
		db.Preload(clause.Associations).Where("first_name = $1", firstName).Find(&students)
	} else if studentId != "" {
		log.Println("studentId: " + studentId)
		db.Preload(clause.Associations).Where("student_id = $1", studentId).Find(&students)
	} else {
		db.Preload(clause.Associations).Find(&students)
		//db.Find(&students)
	}
	closeDB(db)
	c.JSON(200, students)

}

func GetProduct(c *gin.Context) {
	name := c.Query("name")
	price := c.Query("price")
	categoryid := c.Query("categoryid")

	db := connectDB()
	var product []*ProductWithAll
	if name != "" && price != "" {
		log.Println("name: " + name)
		log.Println("price: " + price)
		db.Preload(clause.Associations).Where("name = $1 AND price = $2 ", name, price).Find(&product)
	} else if name != "" {
		log.Println("name: " + name)
		db.Preload(clause.Associations).Where("name = $1", name).Find(&product)
	} else if price != "" {
		log.Println("price: " + price)
		db.Preload(clause.Associations).Where("price = $1", price).Find(&product)
	} else if categoryid != "" {
		log.Println("categoryid: " + categoryid)
		db.Preload(clause.Associations).Where("categoryid = $1", categoryid).Find(&product)
	} else {
		db.Preload(clause.Associations).Find(&product)
	}
	closeDB(db)
	c.JSON(200, product)
}

func GetCustomer(c *gin.Context) {
	name := c.Query("name")
	db := connectDB()
	var customer []*CustomerWithAll
	if name != "" {
		log.Println("name: " + name)
		db.Preload(clause.Associations).Where("name = $1", name).Find(&customer)
	} else {
		db.Preload(clause.Associations).Find(&customer)
	}
	closeDB(db)
	c.JSON(200, customer)

}

func GetOrder(c *gin.Context) {

	customer_id := c.Query("customer_id")
	db := connectDB()
	var order []*OrderWithAll

	if customer_id != "" {
		log.Println("customer_id: " + customer_id)
		db.Preload(clause.Associations).Where("customer_id = $1", customer_id).Find(&order)
	} else {
		db.Preload(clause.Associations).Find(&order)
	}

	closeDB(db)
	c.JSON(200, order)

}

func GetItem(c *gin.Context) {

	order_id := c.Query("order_id")
	db := connectDB()
	var item []*ItemWithAll

	if order_id != "" {
		log.Println("customer_id: " + order_id)
		db.Preload(clause.Associations).Where("order_id = $1", order_id).Find(&item)
	} else {
		db.Preload(clause.Associations).Find(&item)
	}

	closeDB(db)
	c.JSON(200, item)

}

func GetDepartmentByStudentId(c *gin.Context) {
	db := connectDB()
	var student *Student
	db.Where("id = $1", c.Param("StudentId")).Take(&student)
	var department *Department
	db.Where("id = $1", student.DepartmentId).Take(&department)
	closeDB(db)
	c.JSON(200, department)
}

func GetCategoryByCategoryId(c *gin.Context) {
	db := connectDB()
	var product *Product
	db.Preload(clause.Associations).Table("product").Where("id = $1", c.Param("ProductId")).Take(&product)
	var category *Category
	db.Preload(clause.Associations).Table("category").Where("id = $1", product.Category_id).Take(&category)
	closeDB(db)
	c.JSON(200, category)
}

func GetOrderByCustomerId(c *gin.Context) {
	db := connectDB()
	var customer *Customer
	db.Preload(clause.Associations).Table("customer").Where("id = $1", c.Param("CustomerId")).Take(&customer)
	var order *Order
	db.Table("order").Where("customer_id = $1", customer.Id).Take(&order)
	closeDB(db)
	c.JSON(200, order)
}

func GetItemByOrderId(c *gin.Context) {
	db := connectDB()
	var order *Order
	db.Preload(clause.Associations).Table("order").Where("id = $1", c.Param("OrderId")).Take(&order)
	var item *Item
	db.Table("item").Where("order_id = $1", order.Id).Take(&item)
	closeDB(db)
	c.JSON(200, item)
}

func GetStudentById(c *gin.Context) {
	db := connectDB()
	var student *Student
	queryResult := db.Where("id = $1", c.Param("StudentId")).Take(&student)
	if queryResult.Error != nil {
		log.Println(queryResult.Error)
		c.JSON(500, gin.H{
			"message": "query student failed with error: " + queryResult.Error.Error(),
		})
		closeDB(db)
		return
	}
	closeDB(db)
	c.JSON(200, student)
}

func GetProductById(c *gin.Context) {

	db := connectDB()
	var product *Product
	queryResult := db.Preload(clause.Associations).Table("product").Where("id = $1", c.Param("ProductId")).Take(&product)
	if queryResult.Error != nil {
		log.Println(queryResult.Error)
		c.JSON(500, gin.H{
			"message": "query product failed with error: " + queryResult.Error.Error(),
		})
		closeDB(db)
		return
	}
	closeDB(db)
	c.JSON(200, product)
}

func GetCustomerById(c *gin.Context) {

	db := connectDB()
	var customer *Customer
	queryResult := db.Preload(clause.Associations).Table("customer").Where("id = $1", c.Param("CustomerId")).Take(&customer)
	if queryResult.Error != nil {
		log.Println(queryResult.Error)
		c.JSON(500, gin.H{
			"message": "query product failed with error: " + queryResult.Error.Error(),
		})
		closeDB(db)
		return
	}
	closeDB(db)
	c.JSON(200, customer)
}

func GetOrderById(c *gin.Context) {

	db := connectDB()
	var order *Order
	queryResult := db.Preload(clause.Associations).Table("order").Where("id = $1", c.Param("OrderId")).Take(&order)
	if queryResult.Error != nil {
		log.Println(queryResult.Error)
		c.JSON(500, gin.H{
			"message": "query product failed with error: " + queryResult.Error.Error(),
		})
		closeDB(db)
		return
	}
	closeDB(db)
	c.JSON(200, order)
}

func GetCoursesByStudentId(c *gin.Context) {
	db := connectDB()
	var student *StudentWithCourses
	queryResult := db.Preload(clause.Associations).Where("id = $1", c.Param("StudentId")).Take(&student)
	if queryResult.Error != nil {
		log.Println(queryResult.Error)
		c.JSON(500, gin.H{
			"message": "query student failed with error: " + queryResult.Error.Error(),
		})
		closeDB(db)
		return
	}

	closeDB(db)
	c.JSON(200, student.Courses)
}

func StudentSelectCourse(c *gin.Context) {
	db := connectDB()
	//parsing string to uuid
	studentId, err := uuid.Parse(c.Param("StudentId"))
	if err != nil {
		log.Println(err)
		c.JSON(500, gin.H{
			"message": "StudentId is not a valid uuid",
		})
		closeDB(db)
		return
	}
	courseId, err := uuid.Parse(c.Param("CourseId"))
	if err != nil {
		log.Println(err)
		c.JSON(500, gin.H{
			"message": "CourseId is not a valid uuid",
		})
		closeDB(db)
		return
	}
	studentCourseSelection := &StudentCourseSelection{
		StudentId: studentId,
		CourseId:  courseId,
	}

	result := db.Create(&studentCourseSelection)
	if result.Error != nil {
		log.Println(result.Error)

		c.JSON(500, gin.H{
			"message": "do StudentSelectCourse failed with error: " + result.Error.Error(),
		})
		closeDB(db)
		return
	}
	closeDB(db)
	c.JSON(200, studentCourseSelection)
}

func StudentSelectCourseTransactionManuallyExample(c *gin.Context) {
	db := connectDB()
	//parsing string to uuid
	studentId, err := uuid.Parse(c.Param("StudentId"))
	if err != nil {
		log.Println(err)
		c.JSON(500, gin.H{
			"message": "StudentId is not a valid uuid",
		})
		closeDB(db)
		return
	}
	courseId, err := uuid.Parse(c.Param("CourseId"))
	if err != nil {
		log.Println(err)
		c.JSON(500, gin.H{
			"message": "CourseId is not a valid uuid",
		})
		closeDB(db)
		return
	}
	tx := db.Begin()

	studentCourseSelection := &StudentCourseSelection{
		StudentId: studentId,
		CourseId:  courseId,
	}

	result := tx.Create(&studentCourseSelection)
	if result.Error != nil {
		log.Println(result.Error)

		c.JSON(500, gin.H{
			"message": "do StudentSelectCourse failed with error: " + result.Error.Error(),
		})
		tx.Rollback()
		closeDB(db)
		return
	}

	studentCourseSelection2 := &StudentCourseSelection{
		StudentId: studentId,
		CourseId:  courseId,
	}

	result2 := tx.Create(&studentCourseSelection2)
	if result2.Error != nil {
		log.Println(result2.Error)

		c.JSON(500, gin.H{
			"message": "do StudentSelectCourse failed with error: " + result2.Error.Error(),
		})
		tx.Rollback()
		closeDB(db)
		return
	}

	tx.Commit()
	closeDB(db)
	c.JSON(200, studentCourseSelection)

}

func StudentSelectCourseTransactionManuallyWithSavePointExample(c *gin.Context) {
	db := connectDB()
	//parsing string to uuid
	studentId, err := uuid.Parse(c.Param("StudentId"))
	if err != nil {
		log.Println(err)
		c.JSON(500, gin.H{
			"message": "StudentId is not a valid uuid",
		})
		closeDB(db)
		return
	}
	courseId, err := uuid.Parse(c.Param("CourseId"))
	if err != nil {
		log.Println(err)
		c.JSON(500, gin.H{
			"message": "CourseId is not a valid uuid",
		})
		closeDB(db)
		return
	}
	tx := db.Begin()

	studentCourseSelection := &StudentCourseSelection{
		StudentId: studentId,
		CourseId:  courseId,
	}

	result := tx.Create(&studentCourseSelection)
	if result.Error != nil {
		log.Println(result.Error)

		c.JSON(500, gin.H{
			"message": "do StudentSelectCourse failed with error: " + result.Error.Error(),
		})
		tx.Rollback()
		closeDB(db)
		return
	}
	tx.SavePoint("sp1")

	studentCourseSelection2 := &StudentCourseSelection{
		StudentId: studentId,
		CourseId:  courseId,
	}

	result2 := tx.Create(&studentCourseSelection2)
	if result2.Error != nil {
		log.Println(result2.Error)

		tx.RollbackTo("sp1")
	}

	tx.Commit()
	closeDB(db)
	c.JSON(200, studentCourseSelection)

}

func connectDB() *gorm.DB {
	var dsn string = fmt.Sprintf(
		"host=%s user=%s password=%s dbname=%s port=%s sslmode=%s TimeZone=Asia/Taipei",
		envconfig.GetEnv("DB_HOST"), envconfig.GetEnv("DB_USER"), envconfig.GetEnv("DB_PASSWORD"), envconfig.GetEnv("DB_NAME"), envconfig.GetEnv("DB_PORT"), envconfig.GetEnv("DB_WITH_SSL"))

	var db *gorm.DB
	var err error
	if envconfig.GetEnv("DB_Source") == "gcp" {
		db, err = gorm.Open(postgres.New(postgres.Config{
			DriverName: "cloudsqlpostgres",
			DSN:        dsn,
		}), &gorm.Config{
			Logger: logger.Default.LogMode(logger.Info),
		})
	} else {
		db, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	}

	if err != nil {
		panic("failed to connect database")
	}
	return db
}

func closeDB(db *gorm.DB) {
	sqlDB, err := db.DB()
	if err != nil {
		panic("failed to close database")
	}
	sqlDB.Close()
}
