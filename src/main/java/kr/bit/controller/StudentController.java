package kr.bit.controller;

import java.util.List;
import kr.bit.beans.Student;
import kr.bit.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/student")
public class StudentController {

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

    @GetMapping("/search")
    public List<Student> search(String name) {
        return studentService.search(name);
    }

}
