import React from 'react';
import styled from 'styled-components';

const HeaderItemCourse = styled(({ className }) => (
  <header className={className}>
    <div>
      <h5>Communication and Culture</h5>
      <p>
        This group is for people who are in level 3 pathway in the Connect
        Program.
      </p>
    </div>
    <div>
      <div />
      <span>0 of 22 Completed</span>
    </div>
  </header>
))`
  > div:first-child {
    h5 {
      font-size: 1.09rem;
      color: #111111;
      margin-top: 0;
    }

    p {
      color: #9fa6ad;
    }
  }

  > div:last-child {
    display: flex;
    align-items: center;
    margin-bottom: 1.3em;

    div {
      width: 34px;
      height: 34px;
      border: 4px solid #979797;
      border-radius: 50%;
      margin-right: 0.7em;
    }

    span {
      color: #9fa6ad;
      width: 71px;
    }
  }

  @media screen and (min-width: 768px) {
    display: flex;
    justify-content: space-between;
  }
`;

export default HeaderItemCourse;
