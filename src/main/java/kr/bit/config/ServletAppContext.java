package kr.bit.config;


import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.config.annotation.*;

import javax.annotation.Resource;

@Configuration
@EnableWebMvc
@ComponentScan("kr.bit.controller")
@ComponentScan("kr.bit.dao")
@ComponentScan("kr.bit.service")
@PropertySource("/WEB-INF/properties/db.properties")
public class ServletAppContext implements WebMvcConfigurer {

    @Value("${db.classname}")
    private String db_classname;

    @Value("${db.url}")
    private String db_url;

    @Value("${db.username}")
    private String db_username;

    @Value("${db.password}")
    private String db_password;
//
//    //로그인 여부에 따라 상단메뉴바가 다르게 보이도록 하기위해 주입받음
//    @Resource(name="loginBean")
//    private User loginBean;
//
//    @Autowired
//    private TopMenuService topMenuService;
//
//    @Autowired
//    private BoardService boardService;

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        WebMvcConfigurer.super.configureViewResolvers(registry);
        registry.jsp("/WEB-INF/views/", ".jsp");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        WebMvcConfigurer.super.addResourceHandlers(registry);
        registry.addResourceHandler("/**").addResourceLocations("/resources/");
    }

    @Bean
    public BasicDataSource dataSource(){
        BasicDataSource source = new BasicDataSource();
        source.setDriverClassName(db_classname);
        source.setUrl(db_url);
        source.setUsername(db_username);
        source.setPassword(db_password);

        return source;
    }
//
//    @Bean
//    public SqlSessionFactory factory(BasicDataSource source) throws Exception{
//        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
//        factoryBean.setDataSource(source);
//
//        SqlSessionFactory factory = factoryBean.getObject();
//        return factory;  //sql실행, 매핑 인터페이스 처리
//    }
//
//    @Bean
//    public MapperFactoryBean<TopMenuMapper> top_mapper(SqlSessionFactory factory) throws Exception{
//        MapperFactoryBean<TopMenuMapper> fac=
//                new MapperFactoryBean<TopMenuMapper>(TopMenuMapper.class);
//
//        fac.setSqlSessionFactory(factory);
//        return fac;
//    }


//    //인터셉터 등록
//    public void addInterceptors(InterceptorRegistry registry) {
//        WebMvcConfigurer.super.addInterceptors(registry);
//
//        TopMenuInterceptor topMenuInterceptor = new TopMenuInterceptor(topMenuService, loginBean);
//        InterceptorRegistration re1=registry.addInterceptor(topMenuInterceptor);
//        re1.addPathPatterns("/**");  //모든경로로 매핑해도 다 뜨도록 ..컨트롤러 전에 preHandle
//
//        LoginInterceptor loginInterceptor = new LoginInterceptor(loginBean);
//        InterceptorRegistration re2=registry.addInterceptor(loginInterceptor);
//        re2.addPathPatterns("/user/modify","/user/logout","/board/*");
//        re2.excludePathPatterns("/board/main");
//        //이 주소로 들어가기 전에 로그인 여부를 알아내서 로그인이 안되어있다면 user/not_login으로 강제이동
//
//        WriterInterceptor writerInterceptor = new WriterInterceptor(loginBean, boardService);
//        InterceptorRegistration re3=registry.addInterceptor(writerInterceptor);
//        re3.addPathPatterns("/board/modify","/board/delete");
//
//    }

//
//    @Bean
//    public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer(){
//        return new PropertySourcesPlaceholderConfigurer();
//    }
//    //properties파일에 있는 값을 뷰에 출력하기 위해서
//    @Bean
//    public ReloadableResourceBundleMessageSource messageSource(){
//        ReloadableResourceBundleMessageSource res=new ReloadableResourceBundleMessageSource();
//        //res.setDefaultEncoding("UTF-8");
//        res.setBasenames("/WEB-INF/properties/error");
//        return res;
//    }
}





