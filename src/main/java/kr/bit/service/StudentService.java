package kr.bit.service;

import java.util.List;
import kr.bit.beans.Student;
import kr.bit.dao.StudentDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

    @Autowired
    private StudentDAO studentDAO;

    public Student getStudent(int id) {
        return studentDAO.getStudent(id);
    }

    public void add(Student student) {
        studentDAO.save(student);
    }

    public List<Student> getAllStudents() {
        return studentDAO.findAll();
    }

    public List<Student> search(String name) {
        return studentDAO.findByName(name);
    }

    public void delete(int id) {
        studentDAO.infoDelete(id);
        studentDAO.nameDelete(id);
    }

    public void studentUpdate(Student student) {
        studentDAO.infoUpdate(student);
        studentDAO.nameUpdate(student);
    }

}
