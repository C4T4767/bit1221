package kr.bit.mapper;

import kr.bit.beans.Student;
import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface StudentMapper {

    public Student getStudentByName(String name);

    public void studentUpdate(Student student);

    public void studentDelete(String name);
}