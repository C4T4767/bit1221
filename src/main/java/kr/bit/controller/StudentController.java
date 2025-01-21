package kr.bit.controller;

import kr.bit.beans.Student;
import kr.bit.dao.StudentDAO;
import java.util.List;
import kr.bit.beans.Student;
import kr.bit.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentDAO studentDAO;

    @Autowired
    private StudentService studentService;


    @PostMapping("/add")
    public void add(@RequestBody Student student) {
        System.out.println(student.toString());
        studentService.add(student);
    }

    @GetMapping("/all")
    public List<Student> all() {
        return studentService.getAllStudents();
    }

    @GetMapping("/search/{name}")
    public List<Student> search(@PathVariable String name) {
        return studentService.search(name);
    }

    @PutMapping("/update")
    public void studentUpdate(@RequestBody Student student) {
        studentDAO.updateStudent(student.getName(), student);
    }

    @DeleteMapping("/delete/{id}")
    public void studentDelete(@PathVariable("id") int id) {
        studentService.delete(id);
    }
}