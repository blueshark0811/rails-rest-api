import React from 'react';
import styled from 'styled-components';
// base components
import Button from 'base_components/RootButton';
// for modal
import modal from 'hoc/modal';
import { Modal } from 'react-bootstrap';
// assets
import iconSettings from 'resources/images/iconSettings.svg';
// sub-components
import ModalBodyCourses from './components/ModalBodyCourses';
import ModalHeaderCourses from './components/ModalHeaderCourses';

// styled button settings to use for opening modal.
const ButtonSettings = Button.extend`
  margin-right: 0.8em;
  height: fit-content;
  width: fit-content;
  padding: 0;

  img {
    height: 100%;
    width: 100%;
  }
`;

// container of modal courses settings
const ContainerModalCourses = styled.div`
  display: inline-block;
`;

const ModalCoursesSettings = ({ isOpen, onOpen, onClose }) => (
  <ContainerModalCourses>
    <ButtonSettings onClick={onOpen}>
      <img alt="icon settings" src={iconSettings} />
    </ButtonSettings>
    <Modal show={isOpen} onHide={onClose}>
      <ModalHeaderCourses />
      <ModalBodyCourses />
    </Modal>
  </ContainerModalCourses>
);

export default modal(ModalCoursesSettings);
