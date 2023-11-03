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

type StudentWithDepartment struct {
	Student
	// Department represents the department of a student.
	Department *Department `json:"department,omitempty"`
}

func (StudentWithDepartment) TableName() string {
	return "students"
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

func (StudentWithAll) TableName() string {
	return "students"
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

func GetDepartmentByStudentId(c *gin.Context) {
	db := connectDB()
	var student *Student
	db.Where("id = $1", c.Param("StudentId")).Take(&student)
	var department *Department
	db.Where("id = $1", student.DepartmentId).Take(&department)
	closeDB(db)
	c.JSON(200, department)
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
