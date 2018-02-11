import React from 'react';
import styled from 'styled-components';
//
import HeaderReportCourse from './components/HeaderReportCourse';

const ContainerBodyReportCourse = styled.div`
  padding: 1.4em 1.4em 2.9em;
`;

const SectionReportCourse = () => (
  <section>
    <HeaderReportCourse />
    <ContainerBodyReportCourse>
      <span>Pass Amount</span>
    </ContainerBodyReportCourse>
  </section>
);

export default SectionReportCourse;
