package kr.bit.dao;

import java.util.List;
import kr.bit.beans.Student;
import kr.bit.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StudentDAO {

    @Autowired
    private StudentMapper studentMapper;

    public void save(Student student) {
        studentMapper.saveName(student);
        studentMapper.saveInfo(student);
    }

    public List<Student> findAll() {
        return studentMapper.findAll();
    }

    public List<Student> findByName(String name) {
        return studentMapper.findAllByName(name);
    }
}
