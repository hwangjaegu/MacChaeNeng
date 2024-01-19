package com.mcn.MacChaeNeng.salt.model;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SaltServiceImpl implements SaltService{
	private final SaltDAO saltDao;
}
