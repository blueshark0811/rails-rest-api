import React from 'react';
//
import BoxHeaderCourse from './components/BoxHeaderCourse';
import ContainerFlex from 'base_components/ContainerFlex';
import bgImage from '../../course-bg.png';
import settings from 'resources/images/settings.svg';
import iconPencil from 'resources/images/iconPencil.svg';

const ContainerControlButton = ContainerFlex.extend`
  font-size: 12px;
  margin-right: 4em;

  &:last-child {
    margin-right: 0;
  }

  img {
    margin-right: 0.9em;
  }
`;

const HeaderCourseMeta = ({ courseTitle }) => (
  <BoxHeaderCourse
    style={{
      backgroundImage: `url(${bgImage})`
    }}
  >
    <header>
      <div>
        <h3>{courseTitle}</h3>
        <ContainerFlex>
          <ContainerControlButton isAlignCenter>
            <img alt="icon pencil" src={iconPencil} />
            <span>Edit Info</span>
          </ContainerControlButton>
          <ContainerControlButton isAlignCenter>
            <img alt="icon pencil" src={settings} />
            <span>Settings</span>
          </ContainerControlButton>
        </ContainerFlex>
      </div>
    </header>
  </BoxHeaderCourse>
);

export default HeaderCourseMeta;
