select ename, job, sal, RANK() over (ORDER BY sal DESC)as ����
FROM emp
WHERE job in ('ANALYST','MANAGER');

select ename, job, sal, RANK() over (PARTItION BY job 
                                        order by sal DESC)as ����
FROM emp;

--RANK�� 1-1-3-4-5
--DENSE_RANK�� 1-1-2-3-4
select ename, job, sal, RANK() over (ORDER BY sal DESC) AS RANK,
                        DENSE_RANK() over(ORDER BY sal DESC) AS DENSE_RANK
FROM emp
WHERE job in ('ANALYST','MANAGER');


select ename, job, sal, DENSE_RANK() over (PARTItION BY job 
                                        order by sal DESC)as ����
FROM emp
where hiredate BETWEEN to_date('1981/01/01','RRRR/MM/DD')
                And to_date('1981/12/31','RRRR/MM/DD');
         
--������ 2975�� ����� ���޼����� ��ԵǴ��� ���       
select dense_rank(2975) within group(ORDER BY sal DESC) ����
from emp;

--NTILE(N) : ������ ����� N��������� ��޺ο�
--NULLS LAST�� ������ �����ͺ��� ��µǵ��������� -> NULL�� �ǾƷ������
select ename,job, sal,
            NTILE(4) over(order by sal desc nulls last) ���
FROM emp
WHERE job in('ANALYST','MANAGER','CLERK');





--RANK�� 1-1-3-4-5
--DENSE_RANK�� 1-1-2-3-4
--CUME_DIST ������ ��������
select ename, job, sal, RANK() over (ORDER BY sal DESC) AS RANK,
                        DENSE_RANK() over(ORDER BY sal DESC) AS DENSE_RANK,
                        CUME_DIST() over(ORDER BY sal desc) as CUM_DIST
FROM emp;

select ename, job, sal, RANK() over (PARTItION BY job 
                                        order by sal DESC)as ����,
                     CUME_DIST() over (PARTItION BY job 
                                        order by sal DESC)as CUM_DIST
FROM emp;

--LISTAGG�������� �׷������ �ʼ�
select deptno, LISTAGG(ename,',') within group (order by ename)as EMPLOYEE
from emp
group by deptno;

select job, LISTAGG(ename||'('||sal||')',',') within group (order by ename asc)as EMPLOYEE
from emp
group by job;

--LAG (����)
--LEAD (������)
select empno, ename, sal, LAG(sal,1) over (order by sal asc) "�� ��",
LEAD(sal,1) over (order by sal asc)"������"
from emp
where job in ('ANALYST','MANAGER');


--DECODE(A,10,B)=A�� 10�̸� B�� ��� ,�ƴϸ� NULL 
select SUM(DECODE(deptno,10,sal)) as "10",
       SUM(DECODE(deptno,20,sal)) as "20",
       SUM(DECODE(deptno,30,sal)) as "30"
       
       FROM emp;

--PIVOT ���� ����Ҷ����� FROEM ���� ��ȣ�� ����Ͽ� Ư���÷��� �����ؾ��Ѵ�.
select *
from (select deptno, sal from emp)
PIVOT (sum(sal) for deptno in(10,20,30));

--PIVOT���� �ݴ�� ���� ������ ���

select*
from order2;

select*
from order2
UNPIVOT(�Ǽ� for ������ in (BICYCLE, CAMERA,NOTEBOOK));

--���̺� �����Ϳ� NULL���ִٸ� ��¾ȵ� 
update order2 set notebook=NULL where ename='SMITH';

--�̷��� NULL�� �൵ ����� ���Խ�Ű���� INCLUDE NULLS
select *
from order2
UNPIVOT INCLUDE NULLS(�Ǽ� for ������ in(BICYCLE,CAMERA,NOTEBOOK));






