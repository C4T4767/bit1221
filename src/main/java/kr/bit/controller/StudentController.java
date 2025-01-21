package kr.bit.controller;

import kr.bit.beans.Student;
import kr.bit.dao.StudentDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentDAO studentDAO;

    @GetMapping("/{name}")
    public Student studentContent(@PathVariable("name") String name) {
        return studentDAO.getStudentByName(name);
    }

    @PutMapping("/update")
    public void studentUpdate(@RequestBody Student student) {
        studentDAO.updateStudent(student.getName(), student);
    }

    @DeleteMapping("/{name}")
    public void studentDelete(@PathVariable("name") String name) {
        studentDAO.deleteStudent(name);
    }
}